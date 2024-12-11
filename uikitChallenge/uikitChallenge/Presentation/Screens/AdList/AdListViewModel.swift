//
//  AdListViewModel.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import Foundation


class AdListViewModel {
    private let fetchAdListUseCase: FetchAdListUseCaseProtocol
    private(set) var ads: [Ad] = []

    init(fetchAdListUseCase: FetchAdListUseCaseProtocol = FetchAdListUseCase(repository: IdealistaRepository(localDataSource: LocalIdealistaDataSource()))) {
        self.fetchAdListUseCase = fetchAdListUseCase
    }

    func fetchAds(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                self.ads = try await fetchAdListUseCase.fetchAds()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
