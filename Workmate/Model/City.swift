//
//  City.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation
// MARK: - City
struct City: Codable {
    let id: Int?
    let name, timezone: String?
    let country: Country?
}
