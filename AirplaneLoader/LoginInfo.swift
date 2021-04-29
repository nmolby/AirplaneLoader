//
//  LoginInfo.swift
//  AirplaneLoader
//
//  Created by Nathan Molby on 4/25/21.
//

import Foundation
import CryptoKit

class LoginInfo {
    //password: passengerPassword
    static var passengerLogin = [
        "passenger": "13e60f0f189e30c027b0e22e89d19d2bab161a72a357ef8811151504776a71dc"
    ]
    
    //password: checkinPassword
    static var checkinLogin = [
        "checkin": "ee29a78b9b86c6c1aaca2380a66390c5aba233171e12f5ad1fa81ee061975cb4"
    ]
    
    //password: managerPassword
    static var managerLogin = [
        "manager": "d644b68a30ff8201d731e34dc82f4b4fd6776a52856b840512363ae992c57b8c"
    ]
    
    static func validate(userType: UserType, username: String, password: String) -> Bool {
        let hashedPassword = SHA256.hash(data: Data(password.utf8))
        let hashedPasswordString = hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
        
        switch(userType) {
        case .Passenger:
            if let correctPassword = passengerLogin[username] {
                return correctPassword == hashedPasswordString
            }
        case .CheckInAgent:
            if let correctPassword = checkinLogin[username] {
                return correctPassword == hashedPasswordString
            }
        case .Manager:
            if let correctPassword = managerLogin[username] {
                return correctPassword == hashedPasswordString
            }
        }
        
        return false
    }
}
