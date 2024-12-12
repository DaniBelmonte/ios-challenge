//
//  IdealistaUseCaseProtocol.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

protocol FetchAdListUseCaseProtocol {
    func fetchAds() async throws -> [Ad]
}
