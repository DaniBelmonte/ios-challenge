//
//  MoreCharacteristicsDTO.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

struct MoreCharacteristicsDTO: Codable {
    let communityCosts: Double
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: Int
    let constructedArea: Int
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}