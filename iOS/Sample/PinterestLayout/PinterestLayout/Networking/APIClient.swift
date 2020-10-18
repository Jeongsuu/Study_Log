//
//  APIClient.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation

enum APIError: Error {
    case unknown
    case badResponse
    case jsonDecoder
}

/// protocol for APIClient
protocol APIClient {

    var session: URLSession { get }

    func get<T: Codable>(with request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void)

}

// Default Implementation
extension APIClient {
    
    var session: URLSession {
        return URLSession.shared
    }
    
    func get<T: Codable>(with request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) {

        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(APIError.unknown))
                return
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.failure(APIError.badResponse))
                return
            }

            guard let data = data, let value = try? JSONDecoder().decode([T].self, from: data) else {
                completion(.failure(APIError.jsonDecoder))
                return
            }

            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
        
        task.resume()
    }
}
