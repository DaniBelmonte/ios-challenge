//
//  FavoriteAdsDataSource.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 12/12/24.
//

import Foundation

protocol FavoriteAdsDataSourceProtocol {
    func saveFavoritePropertyCode(_ propertyCode: String) throws
    func loadFavoritePropertyCodes() throws -> [String]
}

class FavoriteAdsDataSource: FavoriteAdsDataSourceProtocol {
    private let favoritesKey = "favoritePropertyCodes"

    func saveFavoritePropertyCode(_ propertyCode: String) throws {
        var currentFavorites = try loadFavoritePropertyCodes()
        if !currentFavorites.contains(propertyCode) {
            currentFavorites.append(propertyCode)
        } else {
            try removeFavoritePropertyCode(propertyCode: propertyCode)
        }

        let encoder = JSONEncoder()
        let data = try encoder.encode(currentFavorites)
        UserDefaults.standard.set(data, forKey: favoritesKey)
    }

    func removeFavoritePropertyCode(propertyCode: String) throws {
        var currentFavorites = try loadFavoritePropertyCodes()
        currentFavorites.removeAll(where: { $0 == propertyCode })

        let encoder = JSONEncoder()
        let data = try encoder.encode(currentFavorites)
        UserDefaults.standard.set(data, forKey: favoritesKey)
    }

    func loadFavoritePropertyCodes() throws -> [String] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }

        let decoder = JSONDecoder()
        return try decoder.decode([String].self, from: data)
    }
}
