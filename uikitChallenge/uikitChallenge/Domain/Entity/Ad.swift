//
//  Ad.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

struct Ad: Identifiable, Encodable, Decodable {
    let id: UUID
    let propertyCode: String
    let title: String
    let price: Double
    let currency: String
    let thumbnailUrl: String
    let propertyType: String
    let operation: String
    let size: Double
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let latitude: Double
    let longitude: Double
    let parkingSpace: ParkingSpace?
    var isFavorite: Bool
    var favoriteDate: Date?


    init(dto: AdDTO) {
        self.id = UUID()
        self.propertyCode = dto.propertyCode
        self.title = dto.propertyType.capitalized
        self.price = dto.priceInfo.price.amount
        self.currency = dto.priceInfo.price.currencySuffix
        self.thumbnailUrl = dto.thumbnail
        self.propertyType = dto.propertyType
        self.operation = {
            switch dto.operation.lowercased() {
            case "rent":
                return "rent_operation".localized
            case "sale":
                return "sale_operation".localized
            default:
                return dto.operation.capitalized
            }
        }()
        self.size = dto.size
        self.rooms = dto.rooms
        self.bathrooms = dto.bathrooms
        self.address = dto.address
        self.province = dto.province
        self.municipality = dto.municipality
        self.district = dto.district
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        if let parkingSpaceDTO = dto.parkingSpace {
            self.parkingSpace = ParkingSpace(dto: parkingSpaceDTO)
        } else {
            self.parkingSpace = nil
        }
        self.isFavorite = false
    }
}

struct ParkingSpace: Encodable, Decodable {
    let hasParkingSpace: Bool
    let isIncludedInPrice: Bool

    init(dto: ParkingSpaceDTO) {
        self.hasParkingSpace = dto.hasParkingSpace
        self.isIncludedInPrice = dto.isParkingSpaceIncludedInPrice
    }
}
