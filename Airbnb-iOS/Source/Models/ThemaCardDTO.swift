//
//  ThemaCardDTO.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 11/29/23.
//

import Foundation

// MARK: - ThemaCardDTO
struct ThemaCardDTO: Codable {
    let status: Int
    let message: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let description: String
    let distance: Int
    let travelDate: String
    let price: Int
    let scope: Double
}
