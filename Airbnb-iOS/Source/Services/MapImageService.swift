//
//  MapImageService.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/12/01.
//

import Foundation

class MapImageService {
    func getMapImage(id: Int, completion: @escaping (Result<MapImageDTO, NetworkError>) -> Void) {
        let url = URL(string: "\(Config.baseURL)/api/region")

        guard let url = url else {
            return completion(.failure(.pathErr))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.responseDecodingError))
            }
            let mapResponse = try? JSONDecoder().decode(MapImageDTO.self, from: data)
            if let mapResponse = mapResponse {
                completion(.success(mapResponse))
            } else {
                completion(.failure(.responseError))
            }
        }.resume()
    }
}
