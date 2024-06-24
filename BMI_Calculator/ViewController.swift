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
    // 저장된 데이터 불러오기 및 삭제
    @IBAction func getSavedataBtnTapped(_ sender: UIButton) {
        showLoadAlert { data in
            self.nicknameTextField.text = data[0]
            self.heightTextField.text = data[1]
            self.weightTextField.text = data[2]
        }
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
        showNormalAlert(title: "당신의 BMI는 \(bmiString)이며\n\(result)입니다", alertType: .resultAlert) { _ in
            guard let nickname = self.nicknameTextField.text else { return }
            UserDefaulstManager.shared.saveData(nickname: nickname, height: height, weight: weight)
            self.showNormalAlert(title: SaveAndLoadAlertTexts.saveSuccess.rawValue)
        }
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
                showNormalAlert(title: ErrorCase.isEmptyNickname.rawValue)
            case ErrorCase.isEmpty:
                showNormalAlert(title: ErrorCase.isEmpty.rawValue)
            case ErrorCase.isNotNumber:
                showNormalAlert(title: ErrorCase.isNotNumber.rawValue)
            case ErrorCase.isWrongHeight:
                showNormalAlert(title: ErrorCase.isWrongHeight.rawValue)
            case ErrorCase.isWrongWeight:
                showNormalAlert(title: ErrorCase.isWrongWeight.rawValue)
            default:
                break
            }
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

