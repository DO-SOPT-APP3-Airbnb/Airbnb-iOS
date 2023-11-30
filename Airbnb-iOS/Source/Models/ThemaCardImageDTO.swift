//
//  ThemaCardImageDTO.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 11/29/23.
//

import Foundation

// MARK: - ThemaCardImageDTO
struct ThemaCardImageDTO: Codable {
    let status: Int
    let message: String
    let data: [DatumImage]
}

// MARK: - Datum
struct DatumImage: Codable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}

