//
//  IdealistaUseCase.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

class FetchAdListUseCase: FetchAdListUseCaseProtocol {
    private let repository: IdealistaRepositoryProtocol

    init(repository: IdealistaRepositoryProtocol) {
        self.repository = repository
    }

    func fetchAds() async throws -> [Ad] {
        return try await repository.fetchAdList()
    }
}
