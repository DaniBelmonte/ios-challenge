//
//  AdDetailUseCase.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import Foundation


protocol AdDetailUseCaseProtocol {
    func execute(propertyCode: String) throws -> AdDetail
}

class AdDetailUseCase: AdDetailUseCaseProtocol {
    private let repository: IdealistaRepositoryProtocol

    init(repository: IdealistaRepositoryProtocol) {
        self.repository = repository
    }

    func execute(propertyCode: String) throws -> AdDetail {
        return try repository.getAdDetail(propertyCode: propertyCode)
    }
}
