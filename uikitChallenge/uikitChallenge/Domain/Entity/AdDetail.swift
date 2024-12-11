//
//  PropertyDetail.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

struct AdDetail {
    let propertyCode: String
    let price: Double
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let images: [ImageDetail]
    let comment: String
    let location: Ubication
    let country: String
    let moreCharacteristics: MoreCharacteristics
    let energyCertification: EnergyCertification

    init(dto: AdDetailDTO) {

        self.propertyCode = String(dto.adid)
        self.price = dto.price
        self.operation = dto.operation
        self.propertyType = dto.propertyType
        self.extendedPropertyType = dto.extendedPropertyType
        self.homeType = dto.homeType
        self.state = dto.state
        self.images = dto.multimedia.images.map { ImageDetail(dto: $0) }
        self.comment = dto.propertyComment
        self.location = Ubication(dto: dto.ubication)
        self.country = dto.country
        self.moreCharacteristics = MoreCharacteristics(dto: dto.moreCharacteristics)
        self.energyCertification = EnergyCertification(dto: dto.energyCertification)
    }
}

struct ImageDetail {
    let url: String
    let tag: String

    init(dto: ImageDTO) {
        self.url = dto.url
        self.tag = dto.tag
    }
}

struct Ubication {
    let latitude: Double
    let longitude: Double

    init(dto: UbicationDTO) {
        self.latitude = dto.latitude
        self.longitude = dto.longitude
    }
}

struct MoreCharacteristics {
    let communityCosts: Double
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let isBankAgency: Bool
    let energyType: String
    let location: String
    let modificationDate: String
    let constructedArea: Int
    let hasLift: Bool
    let hasBoxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String

    init(dto: MoreCharacteristicsDTO) {
        self.communityCosts = dto.communityCosts
        self.roomNumber = dto.roomNumber
        self.bathNumber = dto.bathNumber
        self.exterior = dto.exterior
        self.housingFurnitures = dto.housingFurnitures
        self.isBankAgency = dto.agencyIsABank
        self.energyType = dto.energyCertificationType
        self.location = dto.flatLocation
        //TODO: - Ask meaning of numbers in modificationDate
        self.modificationDate = ""
        self.constructedArea = dto.constructedArea
        self.hasLift = dto.lift
        self.hasBoxroom = dto.boxroom
        self.isDuplex = dto.isDuplex
        self.floor = dto.floor
        self.status = dto.status
    }
}

struct EnergyCertification {
    let title: String
    let energyConsumption: String
    let emissions: String

    init(dto: EnergyCertificationDTO) {
        self.title = dto.title
        self.energyConsumption = dto.energyConsumption.type
        self.emissions = dto.emissions.type
    }
}

