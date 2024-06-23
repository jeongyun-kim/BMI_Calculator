//
//  UILabel + Extension.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

extension UILabel {
    func configureLabel(_ textType: LabelText, size: CGFloat = 16, weight: UIFont.Weight = .regular) {
        self.text = textType.rawValue
        self.font = UIFont.systemFont(ofSize: 16, weight: weight)
    }
}
