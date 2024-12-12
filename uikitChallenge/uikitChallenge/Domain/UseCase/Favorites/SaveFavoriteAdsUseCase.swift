//
//  FavoritesUseCase.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 12/12/24.
//

import Foundation

protocol SaveFavoriteAdsUseCaseProtocol {
    func execute(propertyCode: String) throws
}

class SaveFavoriteAdUseCase: SaveFavoriteAdsUseCaseProtocol {
    private let repository: FavoriteAdsRepositoryProtocol

    init(repository: FavoriteAdsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(propertyCode: String) throws {
        try repository.saveFavorite(propertyCode: propertyCode)
    }
}
