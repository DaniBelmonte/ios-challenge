//
//  FavoritesRepository.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

protocol FavoriteAdsRepositoryProtocol {
    func loadFavoritePropertyCodes() throws -> [String]
    func saveFavorite(propertyCode: String) throws
}

class FavoriteAdsRepository: FavoriteAdsRepositoryProtocol {
    private let dataSource: FavoriteAdsDataSourceProtocol

    init(dataSource: FavoriteAdsDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func saveFavorite(propertyCode: String) throws {
        try dataSource.saveFavoritePropertyCode(propertyCode)
    }

    func loadFavoritePropertyCodes() throws -> [String] {
        return try dataSource.loadFavoritePropertyCodes()
    }
}
