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
                    ProgressView("loading_text".localized)
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
                                                Text("image_load_error".localized)
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
                            Text("no_images_available".localized)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                        
                        // MARK: - Title and Price
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("\(adDetail.price, specifier: "%.2f") €")
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
                                    Text(isExpanded ? "see_less_button".localized : "see_more_button".localized)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                        .padding(.top, 4)
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("main_features".localized)
                                .font(.headline)
                            HStack {
                                Text("size_text".localized + " \(adDetail.moreCharacteristics.constructedArea) \("m²".localized)")
                                Text("rooms_text".localized + " \(adDetail.moreCharacteristics.roomNumber)")
                                Text("bathrooms_text".localized + " \(adDetail.moreCharacteristics.bathNumber)")
                            }
                            .font(.subheadline)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // MARK: - Ubication
                        VStack(alignment: .leading, spacing: 8) {
                            Text("location_text".localized)
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
                            Text("additional_info".localized)
                                .font(.headline)
                                .padding(.horizontal)
                            HStack {
                                if adDetail.moreCharacteristics.hasLift {
                                    Text("has_lift".localized)
                                }
                                if adDetail.moreCharacteristics.hasBoxroom {
                                    Text("has_boxroom".localized)
                                }
                                if adDetail.moreCharacteristics.isDuplex {
                                    Text("is_duplex".localized)
                                }
                            }
                            .font(.subheadline)
                            .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("energy_certification".localized)
                                .font(.headline)
                                .padding(.horizontal)
                            Text("energy_type".localized + ": \(adDetail.energyCertification.energyConsumption)")
                                .font(.subheadline)
                                .padding(.horizontal)
                            Text("emissions".localized + ": \(adDetail.energyCertification.emissions)")
                                .font(.subheadline)
                                .padding(.horizontal)
                        }
                    }
                }
            } else {
                //MARK: Error
                VStack(spacing: 16) {
                    Text("ad_load_error".localized)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button(action: {
                        viewModel.fetchAdDetail(propertyCode: propertyCode)
                    }) {
                        Text("retry_button".localized)
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
        .navigationTitle("ad_detail_title".localized)
        .onAppear {
            viewModel.fetchAdDetail(propertyCode: propertyCode)
        }
    }
}

