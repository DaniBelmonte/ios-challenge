//
//  AdListViewModel.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//


import Foundation
import SwiftUI

@MainActor
class AdListViewModel: ObservableObject {
    //MARK: Properties
    @Published var ads: [Ad] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingErrorAlert = false

    private let fetchAdListUseCase: FetchAdListUseCaseProtocol

    init(fetchAdListUseCase: FetchAdListUseCaseProtocol) {
        self.fetchAdListUseCase = fetchAdListUseCase
    }

    func fetchAds() async {
        isLoading = true
        do {
            ads = try await fetchAdListUseCase.fetchAds()
            //show alert to visualize behavior
            showingErrorAlert = true

        } catch {
            errorMessage = "Fail when loading ads: \(error.localizedDescription)"
            showingErrorAlert = true
        }
        isLoading = false
    }
}
