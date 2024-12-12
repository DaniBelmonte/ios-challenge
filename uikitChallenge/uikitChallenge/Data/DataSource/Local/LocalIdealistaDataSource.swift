//
//  LocalIdealistaDataSource.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

protocol LocalIdealistaDataSourceProtocol {
    func getAdDetail(propertyCode: String) throws -> AdDetail
    func fetchAdList() async throws -> [Ad]
}

class LocalIdealistaDataSource: LocalIdealistaDataSourceProtocol {
    func fetchAdList() async throws -> [Ad] {
        guard let url = Bundle.main.url(forResource: "list", withExtension: "json") else {
            throw NSError(domain: "File not found", code: 404, userInfo: nil)
        }

        let data = try Data(contentsOf: url)
        let adDTOs = try JSONDecoder().decode([AdDTO].self, from: data)
        return adDTOs.map { Ad(dto: $0) }
    }
    
    func getAdDetail(propertyCode: String) throws -> AdDetail {
        guard let url = Bundle.main.url(forResource: "detail", withExtension: "json") else {
            throw NSError(domain: "File not found", code: 404, userInfo: nil)
        }

        let data = try Data(contentsOf: url)
        let adDetailDTO = try JSONDecoder().decode(AdDetailDTO.self, from: data)
        
        let adDetail = AdDetail(dto: adDetailDTO)
        
        guard adDetail.propertyCode.contains(propertyCode) else {
            throw NSError(domain: "Property not found", code: 404, userInfo: nil)
        }
        
        return adDetail
    }

}
