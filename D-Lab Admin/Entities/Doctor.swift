//
//  Doctor.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

struct Doctor: Codable {
    let id: Int
    let priceList: String?
    let doctorName, contacts, comment: String

    enum CodingKeys: String, CodingKey {
        case id
        case priceList = "price_list"
        case doctorName = "doctor_name"
        case contacts, comment
    }
}
