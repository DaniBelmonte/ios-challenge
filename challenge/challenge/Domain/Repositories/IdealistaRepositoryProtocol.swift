//
//  IdealistaRepositoryProtocol.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

protocol AdRepositoryProtocol {
    func fetchAdList() async throws -> [Ad]
}
