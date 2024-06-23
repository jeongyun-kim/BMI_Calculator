//
//  UITextField + Extension.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

extension UITextField {
    func configureTextField(placeHolder: Placeholder) {
        self.borderStyle = .none
        self.placeholder = placeHolder.rawValue
    }
    
    func setPaddingInTextField() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.rightViewMode = .always
    }
}
