//
//  AdDetailViewModel.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import Foundation

class AdDetailViewModel: ObservableObject {
    @Published var adDetail: AdDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    

    private let getAdDetailUseCase: AdDetailUseCaseProtocol

    init(getAdDetailUseCase: AdDetailUseCaseProtocol) {
        self.getAdDetailUseCase = getAdDetailUseCase
    }

    func fetchAdDetail(propertyCode: String) {
        isLoading = true
        DispatchQueue.main.async { [self] in
            do {
                let detail = try self.getAdDetailUseCase.execute(propertyCode: propertyCode)
                DispatchQueue.main.async {
                    self.adDetail = detail
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error al obtener el detalle del anuncio: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
