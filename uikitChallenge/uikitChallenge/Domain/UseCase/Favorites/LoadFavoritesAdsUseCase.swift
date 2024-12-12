//
//  LoadFavoritesAdsUseCase.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 12/12/24.
//

import Foundation

protocol LoadFavoriteAdsUseCaseProtocol {
    func execute(allAds: inout [Ad]) throws
}

class LoadFavoriteAdsUseCase: LoadFavoriteAdsUseCaseProtocol {
    private let repository: FavoriteAdsRepositoryProtocol

    init(repository: FavoriteAdsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(allAds: inout [Ad]) throws {
        let favoriteAds = try repository.loadFavoriteAds()

        for index in allAds.indices {
            if let favoriteAd = favoriteAds.first(where: { $0.propertyCode == allAds[index].propertyCode }) {
                allAds[index].isFavorite = true
                allAds[index].favoriteDate = favoriteAd.favoriteDate
            } else {
                allAds[index].isFavorite = false
                allAds[index].favoriteDate = nil
            }
        }
    }
}
