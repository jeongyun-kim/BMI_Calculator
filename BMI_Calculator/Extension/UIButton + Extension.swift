//
//  UIButton + Extension.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

extension UIButton {
    func configureBtn(_ title: ButtonText, size: CGFloat, color: UIColor) {
        self.setTitle(title.rawValue, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: size)
        self.tintColor = color
    }
}
