//
//  Payment.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 15.03.2022.
//

import Foundation

struct Payment: Codable {
    let id: Int
    let doctor: Doctor
    let clinic: Clinic
    let paymentForm, date: String
    let amount: Int
    let comment: String
    let balance: Int

    enum CodingKeys: String, CodingKey {
        case id, doctor, clinic
        case paymentForm = "payment_form"
        case date, amount, comment, balance
    }
}
