//
//  Model.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import Foundation

// MARK: - Item
struct Ad: Codable {
    let id, title: String?
    let price: Price?
    let visits: Int?
    let address: Address?
    let postedDateTime, itemDescription: String?
    let attributes: [Attribute]?
    let features, pictures: [String]?
    let documents: [Document]?

    enum CodingKeys: String, CodingKey {
        case id, title, price, visits, address
        case postedDateTime = "posted-date-time"
        case itemDescription = "description"
        case attributes, features, pictures, documents
    }
}

// MARK: - Address
struct Address: Codable {
    let street, city, zipCode, longitude, latitude: String?

    enum CodingKeys: String, CodingKey {
        case street, city, longitude, latitude
        case zipCode = "zip-code"
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let label, value, unit: String?
}

// MARK: - Document
struct Document: Codable {
    let link, title: String?
}

// MARK: - Price
struct Price: Codable {
    let currency: String?
    let amount: Int?
}
