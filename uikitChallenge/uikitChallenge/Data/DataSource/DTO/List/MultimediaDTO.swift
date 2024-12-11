//
//  MultimediaDTO.swift
//  challenge
//
//  Created by Daniel Belmonte Valero on 10/12/24.
//

import Foundation

struct MultimediaDTO: Codable {
    let images: [ImageDTO]
}

struct ImageDTO: Codable {
    let url: String
    let tag: String
}
