//
//  IdealistaRepository.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

class IdealistaRepository: IdealistaRepositoryProtocol {
    private let localDataSource: LocalIdealistaDataSource

    init(localDataSource: LocalIdealistaDataSource) {
        self.localDataSource = localDataSource
    }

    func fetchAdList() async throws -> [Ad] {
        return try await localDataSource.fetchAdList()
    }
    
    func getAdDetail(propertyCode: String) throws -> AdDetail {
        return try localDataSource.getAdDetail(propertyCode: propertyCode)
    }
}
