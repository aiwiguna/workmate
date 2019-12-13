//
//  Address.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let country: Country?
    let street1, street2, zip: String?
    let latitude,longitude: Double?
    let area: Area?

    enum CodingKeys: String, CodingKey {
        case id, country
        case street1 = "street_1"
        case street2 = "street_2"
        case zip, latitude, longitude, area
    }
}
