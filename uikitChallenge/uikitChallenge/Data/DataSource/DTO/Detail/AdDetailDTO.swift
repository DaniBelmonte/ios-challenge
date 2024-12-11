//
//  AdDetailDTO.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

struct AdDetailDTO: Codable {
    let adid: Int
    let price: Double
    let priceInfo: PriceInfoDTO
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaDTO
    let propertyComment: String
    let ubication: UbicationDTO
    let country: String
    let moreCharacteristics: MoreCharacteristicsDTO
    let energyCertification: EnergyCertificationDTO
}


