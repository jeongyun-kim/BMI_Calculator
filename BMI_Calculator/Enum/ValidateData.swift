//
//  ValidateData.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 6/23/24.
//

import Foundation

enum ErrorCase: String, Error {
    case isEmptyNickname = "닉네임을 입력해주세요"
    case isEmpty = "키와 몸무게를 입력해주세요"
    case isNotNumber = "키, 몸무게는 숫자만 입력해주세요"
    case isWrongHeight = "키를 확인해주세요"
    case isWrongWeight = "몸무게를 확인해주세요"
}
