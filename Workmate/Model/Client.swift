//
//  Client.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

// MARK: - Client
struct Client: Codable {
    let id: Int?
    let name, status, tier: String?
    let website: String?
    let clientDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name, status, tier, website
        case clientDescription = "description"
    }
}
