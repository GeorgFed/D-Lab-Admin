//
//  AuthResponse.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

struct AuthResponse: Decodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
