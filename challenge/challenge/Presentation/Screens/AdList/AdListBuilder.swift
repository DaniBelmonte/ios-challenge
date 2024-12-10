//
//  AdListBuilder.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

final class AdListBuilder {
    init() {}

    @MainActor func build() -> AdListView {
        let localDataSource = LocalIdealistaDataSource()
        let repository = AdRepository(localDataSource: localDataSource)
        let useCase = FetchAdListUseCase(repository: repository)
        let viewModel = AdListViewModel(fetchAdListUseCase: useCase)
        return AdListView(viewModel: viewModel)
    }
}
