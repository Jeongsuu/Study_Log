//
//  APIClient.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation


/// API 통신 관련 에러 열거형
enum APIError: Error {
    case unknown
    case badResponse
    case jsonDecoder
    case imageDownload
    case imageConvert
}

/// APIClient 프로토콜
protocol APIClient {

    var session: URLSession { get }

    func get<T: Codable>(with request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void)

}

// 프로토콜 초기 구현
extension APIClient {

    var session: URLSession {
        return URLSession.shared
    }

    /// 제네릭 HTTP 통신 함수
    /// - Parameters:
    ///   - request: API URL
    ///   - completion: 결과값을 인자로 갖는 클로저
    func get<T: Codable>(with request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) {
        // dataTask 생성
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(APIError.unknown)) // unknown 에러 발생
                return
            }

            // response 바인딩 & status code 체크
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.failure(APIError.badResponse)) // badResponse 에러 발생
                return
            }

            // data 바인딩 & JSON Decoding
            guard let data = data, let photos = try? JSONDecoder().decode([T].self, from: data) else {
                completion(.failure(APIError.jsonDecoder)) // Decoding 에러 발생
                return
            }
            DispatchQueue.main.async {
                completion(.success(photos))
            }
        }
        
        task.resume()
    }
}
