//
//  AdDTO.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

struct AdDTO: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceDTO
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: MultimediaDTO
    let features: FeaturesDTO
    let parkingSpace: ParkingSpaceDTO?
}
