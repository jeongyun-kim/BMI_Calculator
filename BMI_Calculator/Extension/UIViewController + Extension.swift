//
//  UIViewController + Extension.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

extension UIViewController {
    func removeWhitespace(_ text: String) -> String {
        return text.components(separatedBy: " ").joined()
    }
    
    // 일반 Alert / 결과 확인용 Alert
    func showNormalAlert(title: String, alertType: AlertType = .justAlert, completionHandler: @escaping (UIAlertAction) -> Void = { _ in }) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: AlertType.confirm, style: .cancel)
        alert.addAction(confirm)
      
        // Alert가 단순 알림용인지, 결과 확인 후 저장하기용인지
        switch alertType {
        case .justAlert:
            present(alert, animated: true)
        case .resultAlert:
            let save = UIAlertAction(title: AlertType.save, style: .default, handler: completionHandler)
            alert.addAction(save)
            present(alert,animated: true)
        }
    }
    
    func showLoadAlert(completionHandler: @escaping ([String]) -> Void) {
        let alert = UIAlertController(title: SaveAndLoadAlertTexts.mainTitle.rawValue, message: nil, preferredStyle: .alert)
        alert.addTextField()
        // 데이터 불러오기
        let load = UIAlertAction(title: AlertType.load, style: .default) { _ in
            guard let nickname = alert.textFields?.first?.text else {
                return
            }
            let savedata = UserDefaulstManager.shared.getData(nickname: nickname)
            if !savedata.isEmpty {
                completionHandler([nickname, "\(savedata[0])", "\(savedata[1])"])
            } else {
                self.showNormalAlert(title: SaveAndLoadAlertTexts.noData.rawValue)
            }
        }
        // 데이터 리셋
        let reset = UIAlertAction(title: AlertType.delete, style: .destructive) { _ in
            guard let nickname = alert.textFields?.first?.text else { return }
            if !UserDefaulstManager.shared.getData(nickname: nickname).isEmpty {
                UserDefaulstManager.shared.deleteData(nickname: nickname)
                self.showNormalAlert(title: SaveAndLoadAlertTexts.deleteSuccess.rawValue)
            } else {
                self.showNormalAlert(title: SaveAndLoadAlertTexts.noDataToDelete.rawValue)
            }
        }
        // 취소
        let cancel = UIAlertAction(title: AlertType.cancel, style: .cancel)
        alert.addAction(load)
        alert.addAction(reset)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

