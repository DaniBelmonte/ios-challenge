//
//  LocalIdealistaDataSource.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import Foundation

class LocalIdealistaDataSource {
    func fetchAdList() async throws -> [Ad] {
        guard let url = Bundle.main.url(forResource: "list", withExtension: "json") else {
            throw NSError(domain: "File not found", code: 404, userInfo: nil)
        }

        let data = try Data(contentsOf: url)
        let adDTOs = try JSONDecoder().decode([AdDTO].self, from: data)
        return adDTOs.map { Ad(dto: $0) }
    }
}
