//
//  AdDetailBuilder.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import SwiftUI
import UIKit

final class AdDetailBuilder {
    init() {}

    func build(propertyCode: String) -> AdDetailView {
        let datasource = LocalIdealistaDataSource()
        let repository = IdealistaRepository(localDataSource: datasource)
        let useCase = AdDetailUseCase(repository: repository)
        let viewModel = AdDetailViewModel(getAdDetailUseCase: useCase)
        let detailView = AdDetailView(propertyCode: propertyCode, viewModel: viewModel)
        return detailView
    }
}
