//
//  FeaturesDTO.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

struct FeaturesDTO: Codable {
    let hasAirConditioning: Bool
    let hasBoxRoom: Bool
    let hasSwimmingPool: Bool?
    let hasTerrace: Bool?
    let hasGarden: Bool?
}
