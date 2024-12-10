//
//  AdCellView.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import SwiftUI

struct AdCellView: View {
    let ad: Ad

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //MARK: Image
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: ad.thumbnailUrl)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)
            }

            //MARK: Details
            VStack(alignment: .leading, spacing: 5) {
                Text(ad.title)
                    .font(.headline)
                    .foregroundColor(.blue)

                HStack {
                    Text("\(ad.price, specifier: "%.0f") \(ad.currency)")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                }

                if let parkingSpace = ad.parkingSpace, parkingSpace.hasParkingSpace {
                    Text(parkingSpace.isIncludedInPrice ? "Garaje incluido en el precio" : "Garaje disponible")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack(spacing: 15) {
                    Text("\(ad.rooms) hab.")
                        .font(.subheadline)
                    Text("\(ad.size, specifier: "%.0f") m²")
                        .font(.subheadline)
                }

                Text("Descubre más sobre este inmueble en \(ad.address).")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }

            HStack {

                Spacer()

                Button(action: {
                    print("Favorito")
                }) {
                    Image(systemName: "heart")
                        .font(.title3)
                        .padding(10)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
