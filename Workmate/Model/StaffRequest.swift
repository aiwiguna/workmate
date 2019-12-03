//
//  StaffRequest.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation

// MARK: - StaffRequest
struct StaffRequest: Codable {
    let id: Int?
    let createdDate, modifiedDate, status, uid: String?
    let title, coverImage, staffRequestDescription, wageAmount: String?
    let wageType: String?
    let staffRequired: Int?
    let timezone: String?
    let minAge, maxAge: Int?
    let requireExperience, requireEnglish: Bool?
    let offerStatistics: OfferStatistics?
    let offerCounts: [String: Int]?
    let startTime, endTime: String?
    let fixedLocation: Bool?
    let schedules: [Schedule]?
    let client: Client?
    let location: Location?
    let position: Position?
    let manager: Manager?

    enum CodingKeys: String, CodingKey {
        case id
        case createdDate = "created_date"
        case modifiedDate = "modified_date"
        case status, uid, title
        case coverImage = "cover_image"
        case staffRequestDescription = "description"
        case wageAmount = "wage_amount"
        case wageType = "wage_type"
        case staffRequired = "staff_required"
        case timezone
        case minAge = "min_age"
        case maxAge = "max_age"
        case requireExperience = "require_experience"
        case requireEnglish = "require_english"
        case offerStatistics = "offer_statistics"
        case offerCounts = "offer_counts"
        case startTime = "start_time"
        case endTime = "end_time"
        case fixedLocation = "fixed_location"
        case schedules, client, location, position, manager
    }
}
















