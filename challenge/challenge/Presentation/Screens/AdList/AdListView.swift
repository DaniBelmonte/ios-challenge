//
//  ContentView.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 9/12/24.
//

import SwiftUI

struct AdListView: View {
    @StateObject var viewModel: AdListViewModel
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    if isRefreshing {
                        HStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                            Text("Cargando...")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    LazyVStack(spacing: 20) {
                        if viewModel.isLoading && viewModel.ads.isEmpty {
                            ProgressView("Cargando anuncios...")
                        } else {
                            ForEach(viewModel.ads) { ad in
                                AdCellView(ad: ad)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Anuncios")
            .refreshable {
                await refreshAds()
            }
            .onAppear {
                Task {
                    await viewModel.fetchAds()
                }
            }
            .alert("Error", isPresented: $viewModel.showingErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Ocurrió un error desconocido.")
            }
        }
    }
    
    private func refreshAds() async {
        isRefreshing = true
        await viewModel.fetchAds()
        isRefreshing = false
    }
}

#Preview {
    AdListBuilder().build()
}
