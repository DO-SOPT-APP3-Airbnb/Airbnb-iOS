//
//  themaCardImageService.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 11/29/23.
//

import Foundation

class themaCardImageService {
    func getThemaCardImage(id: Int, completion: @escaping (Result<ThemaCardImageDTO, NetworkError>) -> Void) {
        let url = URL(string: "\(Config.baseURL)/api/dormitory/image/\(id)")

        guard let url = url else {
            return completion(.failure(.pathErr))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.responseDecodingError))
            }
            let themaCardResponse = try? JSONDecoder().decode(ThemaCardImageDTO.self, from: data)
            if let themaCardResponse = themaCardResponse {
                completion(.success(themaCardResponse))
            } else {
                completion(.failure(.responseError))
            }
        }.resume()
    }
}
