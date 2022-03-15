//
//  PathFactory.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

struct PathFactory {
    let baseURL: URL!
    
    init(base: String) {
        guard let url = URL(string: base) else { assert(false) }
        self.baseURL = url
    }
    
    let auth = "/api/token_auth/"
    let orders = "/api/orders/"
    let doctors = "/api/doctors/"
    let clinics = "/api/clinics/"
    let payments = "/api/payments/"
}
