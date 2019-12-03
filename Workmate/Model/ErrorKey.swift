//
//  ErrorKey.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

// MARK: - ErrorKey
struct ErrorKey: Codable {
    let nonFieldErrors: [String]?

    enum CodingKeys: String, CodingKey {
        case nonFieldErrors = "non_field_errors"
    }
}
