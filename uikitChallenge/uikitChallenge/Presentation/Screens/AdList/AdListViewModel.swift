//
//  AdListViewModel.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import Foundation


class AdListViewModel {
    //MARK: Properties
    private let fetchAdListUseCase: FetchAdListUseCaseProtocol
    private let saveFavoriteAdUseCase: SaveFavoriteAdsUseCaseProtocol
    private let loadFavoriteAdsUseCase: LoadFavoriteAdsUseCaseProtocol

    private(set) var ads: [Ad] = []
    private(set) var favoriteAds: [Ad] = []

    init(
        fetchAdListUseCase: FetchAdListUseCaseProtocol = FetchAdListUseCase(repository: IdealistaRepository(localDataSource: LocalIdealistaDataSource())),
        saveFavoriteAdUseCase: SaveFavoriteAdsUseCaseProtocol = SaveFavoriteAdUseCase(repository: FavoriteAdsRepository(dataSource: FavoriteAdsDataSource())),
        loadFavoriteAdsUseCase: LoadFavoriteAdsUseCaseProtocol = LoadFavoriteAdsUseCase(repository: FavoriteAdsRepository(dataSource: FavoriteAdsDataSource()))
    ) {
        self.fetchAdListUseCase = fetchAdListUseCase
        self.saveFavoriteAdUseCase = saveFavoriteAdUseCase
        self.loadFavoriteAdsUseCase = loadFavoriteAdsUseCase
    }

    //MARK: Funtions
    func fetchAds(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                self.ads = try await fetchAdListUseCase.fetchAds()

                try loadFavoriteAdsUseCase.execute(allAds: &self.ads)
                
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func toggleFavorite(for ad: Ad, completion: @escaping (Result<Void, Error>) -> Void) {
        if let index = ads.firstIndex(where: { $0.propertyCode == ad.propertyCode }) {
            ads[index].isFavorite.toggle()
            
            do {
                try saveFavoriteAdUseCase.execute(propertyCode: ad.propertyCode)
                
                completion(.success(()))
                
            } catch {
                completion(.failure(error))
            }
        }
    }
}
