//
//  Model.swift
//  FetchJson
//
//  Created by Yeongwoo Kim on 2022/03/31.
//

import Foundation

class UserModel{
    struct User: Codable{
        let id: String
        let name: String
        let nickname: String
        let email: String
        let password: String
        
        init(name: String, nickname: String, email: String, password: String){
            self.id="0"
            self.name=name
            self.nickname=nickname
            self.email=email
            self.password=password
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
