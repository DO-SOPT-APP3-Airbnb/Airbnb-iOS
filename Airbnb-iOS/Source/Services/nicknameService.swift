//
//  nicknameService.swift
//  Airbnb-iOS
//
//  Created by Hyori Choi on 12/1/23.
//

import Foundation

class nicknameService {
    func getUser(id: Int, completion: @escaping (Result<NicknameDTO, NetworkError>) -> Void) {
        let url = URL(string: "\(Config.baseURL)/api/user/\(id)")

        guard let url = url else {
            return completion(.failure(.pathErr))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.responseDecodingError))
            }
            let UserResponse = try? JSONDecoder().decode(NicknameDTO.self, from: data)
            if let UserResponse = UserResponse {
                completion(.success(UserResponse))
            } else {
                completion(.failure(.responseError))
            }
        }.resume()
    }
}
