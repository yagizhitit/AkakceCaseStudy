//
//  Product.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 25.12.2024.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
