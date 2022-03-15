//
//  UsersCreds.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

struct UserCreds: Encodable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
}
