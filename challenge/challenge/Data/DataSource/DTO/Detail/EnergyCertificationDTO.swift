//
//  EnergyCertificationDTO.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

struct EnergyCertificationDTO: Codable {
    let title: String
    let energyConsumption: EnergyConsumptionDTO
    let emissions: EmissionsDTO
}
