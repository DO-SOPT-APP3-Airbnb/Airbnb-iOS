//
//  MapImageDTO.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/12/01.
//

import Foundation

// MARK: - MapImageDTO
struct MapImageDTO: Codable {
    let status: Int
    let message: String
    let data: [MapData]
}

// MARK: - MapData
struct MapData: Codable {
    let regionName: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case regionName
        case imageURL = "imageUrl"
    }
}
