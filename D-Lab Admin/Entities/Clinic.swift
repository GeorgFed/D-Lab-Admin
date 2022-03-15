//
//  Clinic.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

struct Clinic: Codable {
    let id: Int
    let priceList: String?
    let clinicName, contacts, comment: String

    enum CodingKeys: String, CodingKey {
        case id
        case priceList = "price_list"
        case clinicName = "clinic_name"
        case contacts, comment
    }
}
