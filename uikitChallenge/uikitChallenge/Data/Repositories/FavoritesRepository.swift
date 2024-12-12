//
//  FavoritesRepository.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

protocol FavoriteAdsRepositoryProtocol {
    func saveFavoriteAd(_ ad: Ad) throws
    func loadFavoriteAds() throws -> [Ad]
}

class FavoriteAdsRepository: FavoriteAdsRepositoryProtocol {
    private let dataSource: FavoriteAdsDataSourceProtocol

    init(dataSource: FavoriteAdsDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func saveFavoriteAd(_ ad: Ad) throws {
        try dataSource.saveFavoriteAd(ad)
    }

    func loadFavoriteAds() throws -> [Ad] {
        return try dataSource.loadFavoriteAds()
    }
}
