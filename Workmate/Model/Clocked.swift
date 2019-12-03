//
//  Clocked.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

// MARK: - Clocked
struct Clocked: Codable {
    let timesheet: Timesheet?
    let requireFeedback: Bool?

    enum CodingKeys: String, CodingKey {
        case timesheet
        case requireFeedback = "require_feedback"
    }
}

