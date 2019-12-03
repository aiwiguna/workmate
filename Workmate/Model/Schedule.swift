//
//  Schedule.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation
// MARK: - Schedule
struct Schedule: Codable {
    let id, staffRequest: Int?
    let recurrences: String?
    let startDate: String?
    let startTime, endTime, duration: String?

    enum CodingKeys: String, CodingKey {
        case id
        case staffRequest = "staff_request"
        case recurrences
        case startDate = "start_date"
        case startTime = "start_time"
        case endTime = "end_time"
        case duration
    }
}
