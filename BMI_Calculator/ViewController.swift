//
//  ViewController.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 5/21/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var getSavedataBtn: UIButton!
    @IBOutlet var weightView: UIView!
    @IBOutlet var heightView: UIView!
    @IBOutlet var calculateBtn: UIButton!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var q2Label: UILabel!
    @IBOutlet var q1Label: UILabel!
    @IBOutlet var randomCalculateBtn: UIButton!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: UI관련
extension ViewController {
    func setupUI() {
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.configureLabel(.title, size: 26, weight: .bold)
        
        descLabel.numberOfLines = 0
        descLabel.configureLabel(.desc, size: 18)
    
        nickNameLabel.configureLabel(.nickname)
        
        q1Label.configureLabel(.q1)
        q2Label.configureLabel(.q2)

        heightTextField.configureTextField(placeHolder: .height)
        weightTextField.configureTextField(placeHolder: .weight)
        nicknameTextField.configureTextField(placeHolder: .nickname)
        nicknameTextField.setPaddingInTextField()
        
        [nicknameTextField, heightView, weightView].forEach { view in
            view?.configureUIView()
        }
        
        randomCalculateBtn.configureBtn(.random, size: 14, color: .systemRed)
        
        calculateBtn.configureBtn(.getResult, size: 17, color: .white)
        calculateBtn.backgroundColor = .purple
        calculateBtn.layer.cornerRadius = 12
        
        getSavedataBtn.configureBtn(.loadAndReset, size: 14, color: .systemBlue)
    }
}

// MARK: 액션
extension ViewController {
    @IBAction func getSavedataBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: AlertTitle.mainTitle.rawValue, message: nil, preferredStyle: .alert)
        alert.addTextField()
        // 데이터 불러오기
        let load = UIAlertAction(title: "불러오기", style: .default) { _ in
            guard let nickname = alert.textFields?.first?.text else {
                return
            }
            if let savedata = UserDefaults.standard.array(forKey: nickname) {
                self.nicknameTextField.text = nickname
                self.heightTextField.text = "\(savedata[0])"
                self.weightTextField.text = "\(savedata[1])"
            } else {
                self.showAlert(title: AlertTitle.noData.rawValue)
            }
        }
        // 데이터 리셋
        let reset = UIAlertAction(title: "데이터 삭제", style: .destructive) { _ in
            guard let nickname = alert.textFields?.first?.text else { return }
            if let savedata = UserDefaults.standard.array(forKey: nickname) {
                UserDefaults.standard.removeObject(forKey: nickname)
                self.showAlert(title: AlertTitle.deleteSuccess.rawValue)
            } else {
                self.showAlert(title: AlertTitle.noDataToDelete.rawValue)
            }
        }
        // 취소
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(load)
        alert.addAction(reset)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func validateData(nickname: String, weight: String, height: String) throws {
        guard !nickname.isEmpty else {
            throw ErrorCase.isEmptyNickname
        }
        guard !weight.isEmpty && !height.isEmpty else {
            throw ErrorCase.isEmpty
        }
        guard Float(height) != nil && Float(weight) !=  nil else {
            throw ErrorCase.isNotNumber
        }
        let heightFloat = Float(height)!
        let weightFloat = Float(weight)!
        guard heightFloat >= 100 && heightFloat < 250 else {
            throw ErrorCase.isWrongHeight
        }
        guard weightFloat >= 20 && weightFloat <= 200 else {
            throw ErrorCase.isWrongWeight
        }
       calculateBMI(weight: weightFloat, height: heightFloat)
    }
    
    // BMI : weight/(height*height*0.0001)
    func calculateBMI(weight: Float, height: Float) {
        let bmi = weight/(height*height*0.0001)
        var result: String
        // bmi에 따른 체중 구분
        switch bmi {
        case ..<18.5:
            result = "저체중🥺"
        case 18.5...22.9:
            result = "정상체중😉"
        case 23..<24.9:
            result = "비만😅"
        default:
            result = "과체중🥲"
        }
        let bmiString = String(format: "%.2f", bmi)
        showAlert(title: "당신의 BMI는 \(bmiString)이며\n\(result)입니다", alertType: .resultAlert, weight: weight, height: height)
    }
    
    @IBAction func calculateBtnTapped() {
        // 공백 제거
        let nickname = removeWhitespace(nicknameTextField.text!)
        let weight = removeWhitespace(weightTextField.text!)
        let height = removeWhitespace(heightTextField.text!)
        do {
            try validateData(nickname: nickname, weight: weight, height: height)
        } catch {
            switch error {
            case ErrorCase.isEmptyNickname:
                showAlert(title: ErrorCase.isEmptyNickname.rawValue)
            case ErrorCase.isEmpty:
                showAlert(title: ErrorCase.isEmpty.rawValue)
            case ErrorCase.isNotNumber:
                showAlert(title: ErrorCase.isNotNumber.rawValue)
            case ErrorCase.isWrongHeight:
                showAlert(title: ErrorCase.isWrongHeight.rawValue)
            case ErrorCase.isWrongWeight:
                showAlert(title: ErrorCase.isWrongWeight.rawValue)
            default:
                break
            }
        }
    }
    
    func showAlert(title: String, alertType: AlertType = .justAlert, weight: Float? = nil, height: Float? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .cancel)
        let save = UIAlertAction(title: "저장", style: .default) { _ in
            guard let nickname = self.nicknameTextField.text else { return }
            UserDefaults.standard.set([height, weight], forKey: nickname)
            self.showAlert(title: AlertTitle.saveSuccess.rawValue)
        }
        alert.addAction(confirm)
        // 만약 BMI 계산을 거치지 않은 단순 알림창이라면
        switch alertType {
        case .justAlert:
            present(alert, animated: true)
        case .resultAlert:
            alert.addAction(save)
            present(alert,animated: true)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func randomBtnTapped(_ sender: UIButton) {
        let weight: Float = Float.random(in: 20...200)
        let height: Float = Float.random(in: 100...250)
        weightTextField.text = String(format: "%.2f", weight)
        heightTextField.text = String(format: "%.2f", height)
    }
}

