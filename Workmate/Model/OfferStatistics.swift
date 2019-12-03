//
//  OfferStatistic.swift
//  Workmate
//
//  Created by Antoni on 03/12/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import Foundation
// MARK: - OfferStatistics
struct OfferStatistics: Codable {
    let sent, viewed, applied, confirmed: Int?
}
