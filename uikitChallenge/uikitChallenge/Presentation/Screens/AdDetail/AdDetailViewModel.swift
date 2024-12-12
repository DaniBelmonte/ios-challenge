//
//  AdDetailViewModel.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import Foundation

class AdDetailViewModel: ObservableObject {
    //MARK: Properties
    @Published var adDetail: AdDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let getAdDetailUseCase: AdDetailUseCaseProtocol

    init(getAdDetailUseCase: AdDetailUseCaseProtocol) {
        self.getAdDetailUseCase = getAdDetailUseCase
    }

    //MARK: Functions
    func fetchAdDetail(propertyCode: String) {
        isLoading = true
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            do {
                let detail = try self.getAdDetailUseCase.execute(propertyCode: propertyCode)
                DispatchQueue.main.async {
                    self.adDetail = detail
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "ad_detail_fetch_error".localized + ": \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
