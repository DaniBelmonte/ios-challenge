//
//  FavoritesUseCase.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 12/12/24.
//

import Foundation

protocol SaveFavoriteAdUseCaseProtocol {
    func execute(ad: Ad) throws
}

class SaveFavoriteAdUseCase: SaveFavoriteAdUseCaseProtocol {
    private let repository: FavoriteAdsRepositoryProtocol

    init(repository: FavoriteAdsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(ad: Ad) throws {
        try repository.saveFavoriteAd(ad)
    }
}
