//
//  Country.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation
// MARK: - Country
struct Country: Codable {
    let id: Int?
    let name, code, currencyCode, dialCode: String?

    enum CodingKeys: String, CodingKey {
        case id, name, code
        case currencyCode = "currency_code"
        case dialCode = "dial_code"
    }
}
