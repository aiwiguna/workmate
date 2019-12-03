//
//  TimeSheet.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

// MARK: - Timesheet
struct Timesheet: Codable {
    let id: Int?
    let clockInTime, clockOutTime, clockInLatitude, clockInLongitude: String?
    let clockOutLatitude, clockOutLongitude: String?

    enum CodingKeys: String, CodingKey {
        case id
        case clockInTime = "clock_in_time"
        case clockOutTime = "clock_out_time"
        case clockInLatitude = "clock_in_latitude"
        case clockInLongitude = "clock_in_longitude"
        case clockOutLatitude = "clock_out_latitude"
        case clockOutLongitude = "clock_out_longitude"
    }
}
