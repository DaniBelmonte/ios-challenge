//
//  FavoritesRepository.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

protocol FavoriteRepositoryProtocol {
    func addFavorite(propertyCode: String)
    func removeFavorite(propertyCode: String)
    func isFavorite(propertyCode: String) -> Bool
    func getAllFavorites() -> [String]
}

class FavoriteRepository: FavoriteRepositoryProtocol {
    private let favoritesKey = "favoritePropertyCodes"

    func addFavorite(propertyCode: String) {
        var favorites = getAllFavorites()
        if !favorites.contains(propertyCode) {
            favorites.append(propertyCode)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(propertyCode: String) {
        var favorites = getAllFavorites()
        if let index = favorites.firstIndex(of: propertyCode) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }

    func isFavorite(propertyCode: String) -> Bool {
        return getAllFavorites().contains(propertyCode)
    }

    func getAllFavorites() -> [String] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
    }

    private func saveFavorites(_ favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
}
