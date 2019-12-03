//
//  Location.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation
// MARK: - Location
struct Location: Codable {
    let createdDate, modifiedDate: String?
    let id: Int?
    let name: String?
    let address: Address?
    let isPrimary: Bool?

    enum CodingKeys: String, CodingKey {
        case createdDate = "created_date"
        case modifiedDate = "modified_date"
        case id, name, address
        case isPrimary = "is_primary"
    }
}
