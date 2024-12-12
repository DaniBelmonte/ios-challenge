//
//  FavoriteAdsDataSource.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 12/12/24.
//

import Foundation

protocol FavoriteAdsDataSourceProtocol {
    func saveFavoriteAd(_ ad: Ad) throws
    func loadFavoriteAds() throws -> [Ad]
}

class FavoriteAdsDataSource: FavoriteAdsDataSourceProtocol {
    private let favoritesKey = "favoriteAds"

    func saveFavoriteAd(_ ad: Ad) throws {
        var favorites: [Ad] = try loadFavoriteAds()
        
        if let index = favorites.firstIndex(where: { $0.propertyCode == ad.propertyCode }) {
            favorites.remove(at: index)
        } else {
            favorites.append(ad)
        }

        let data = try JSONEncoder().encode(favorites)
        UserDefaults.standard.set(data, forKey: favoritesKey)
    }

    func loadFavoriteAds() throws -> [Ad] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([Ad].self, from: data) else {
            return []
        }
        return favorites
    }
}
