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
        let favoritePropertyCodes = try repository.loadFavoritePropertyCodes()

        for index in allAds.indices {
            allAds[index].isFavorite = favoritePropertyCodes.contains(allAds[index].propertyCode)
        }
    }
}
