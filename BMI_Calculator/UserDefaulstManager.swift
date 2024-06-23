//
//  UserDefaultManager.swift
//  BMI_Calculator
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

class UserDefaulstManager {
    static let shared = UserDefaulstManager()
    
    let standard = UserDefaults.standard
   
    
    func getData(nickname: String) -> [Any] {
        return standard.array(forKey: nickname) ?? []
    }
    
    func saveData(nickname: String, height: Float, weight: Float) {
        standard.set([height, weight], forKey: nickname)
    }
    
    func deleteData(nickname: String) {
        standard.removeObject(forKey: nickname)
    }
}
