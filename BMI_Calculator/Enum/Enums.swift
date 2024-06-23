//
//  Enums.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 6/23/24.
//

import Foundation

enum AlertType {
    case justAlert
    case resultAlert
}

enum AlertTitle: String {
    case mainTitle = "닉네임을 입력해주세요"
    case noData = "해당 닉네임으로 저장된 데이터가 없습니다!"
    case deleteSuccess = "삭제가 완료되었습니다!"
    case noDataToDelete = "삭제할 데이터가 없습니다!"
    case saveSuccess = "저장이 완료되었습니다!"
}

enum LabelText: String {
    case title = "BMI Calculator"
    case desc = "당신의 BMI 지수를 알려드릴게요."
    case nickname = "닉네임이 어떻게 되시나요?"
    case q1 = "키가 어떻게 되시나요?"
    case q2 = "몸무게는 어떻게 되시나요?"
}

enum Placeholder: String {
    case height = "키를 입력해주세요 (100이상 250이하)"
    case weight = "몸무게를 입력해주세요 (20이상 200이하)"
    case nickname = "닉네임을 입력해주세요"
}

enum ButtonText: String {
    case random = "랜덤으로 BMI 계산하기"
    case getResult = "결과확인"
    case loadAndReset = "데이터 불러오기 및 리셋"
}
