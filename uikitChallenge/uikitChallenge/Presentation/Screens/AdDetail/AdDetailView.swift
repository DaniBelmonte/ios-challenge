//
//  AdDetail.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import SwiftUI
import _MapKit_SwiftUI

struct AdDetailView: View {
    let propertyCode: String
    @StateObject private var viewModel: AdDetailViewModel
    @State private var isExpanded: Bool = false
    
    public init(propertyCode: String, viewModel: AdDetailViewModel) {
        self.propertyCode = propertyCode
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        Group {
            //MARK: - Loader
            if viewModel.isLoading {
                VStack {
                    ProgressView("Cargando...")
                }
            } else if let adDetail = viewModel.adDetail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // MARK: - Images
                        if !adDetail.images.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(adDetail.images, id: \.url) { image in
                                        AsyncImage(url: URL(string: image.url)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } else if phase.error != nil {
                                                Color.red
                                            } else {
                                                ProgressView()
                                            }
                                        }
                                        .frame(width: 300, height: 200)
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("No hay imágenes disponibles.")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                        
                        // MARK: - Title and Price
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Precio: \(adDetail.price, specifier: "%.2f") €")
                                    .font(.title2)
                                Spacer()
                                Text(adDetail.operation.capitalized)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(adDetail.comment)
                                    .font(.caption)
                                    .fontWeight(.thin)
                                    .lineLimit(isExpanded ? nil : 2)
                                    .animation(.easeIn, value: isExpanded)
                                
                                Button(action: {
                                    isExpanded.toggle()
                                }) {
                                    Text(isExpanded ? "Ver menos" : "Ver más")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                        .padding(.top, 4)
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        
                        // Características principales
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Características principales")
                                .font(.headline)
                            HStack {
                                Text("📏 \(adDetail.moreCharacteristics.constructedArea) m²")
                                Text("🏡 \(adDetail.propertyType.capitalized)")
                                Text("🚪 \(adDetail.moreCharacteristics.roomNumber) habitaciones")
                                Text("🛁 \(adDetail.moreCharacteristics.bathNumber) baños")
                            }
                            .font(.subheadline)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // MARK: - Ubication
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ubicación")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Map(coordinateRegion: .constant(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: adDetail.location.latitude, longitude: adDetail.location.longitude),
                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                )
                            ), interactionModes: [])
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        // MARK: - Additional Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Información adicional")
                                .font(.headline)
                                .padding(.horizontal)
                            HStack {
                                if adDetail.moreCharacteristics.hasLift {
                                    Text("🛗 Ascensor")
                                }
                                if adDetail.moreCharacteristics.hasBoxroom {
                                    Text("📦 Trastero")
                                }
                                if adDetail.moreCharacteristics.isDuplex {
                                    Text("🏢 Dúplex")
                                }
                            }
                            .font(.subheadline)
                            .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        // Certificación energética
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Certificación energética")
                                .font(.headline)
                                .padding(.horizontal)
                            Text("🔋 Tipo: \(adDetail.energyCertification.energyConsumption)")
                                .font(.subheadline)
                                .padding(.horizontal)
                            Text("🌿 Emisiones: \(adDetail.energyCertification.emissions)")
                                .font(.subheadline)
                                .padding(.horizontal)
                        }
                    }
                }
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    Text("No se ha podido cargar la información del anuncio.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button(action: {
                        viewModel.fetchAdDetail(propertyCode: propertyCode)
                    }) {
                        Text("Reintentar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Detalle del Anuncio")
        .onAppear {
            viewModel.fetchAdDetail(propertyCode: propertyCode)
        }
    }
}

