//
//  nicknameDTO.swift
//  Airbnb-iOS
//
//  Created by Hyori Choi on 12/1/23.
//

import Foundation

// MARK: - User
struct NicknameDTO: Codable {
    let status: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let nickname: String
}
