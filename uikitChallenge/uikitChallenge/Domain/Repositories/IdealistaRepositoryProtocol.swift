//
//  IdealistaRepositoryProtocol.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

protocol IdealistaRepositoryProtocol {
    func fetchAdList() async throws -> [Ad]
    func getAdDetail(propertyCode: String) throws -> AdDetail
}
