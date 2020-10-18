//
//  UnsplashClient.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation

class UnsplashClient: APIClient {
    
    static let baseURL: String = UnsplashEndPoint.baseURL
    static let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    
    
    /// endPoint로 request 송신
    /// - Parameters:
    ///   - endPoint: request 보낼 최종 URL
    ///   - completion: 결과값을 인자로 갖는 핸들러
    func fetch(with endPoint: UnsplashEndPoint, completion: @escaping (Result<Photos, Error>) -> Void) {
        let request = endPoint.request
        
        // 초기 구현한 get 함수 사용, completion으로 completion 전달
        get(with: request, completion: completion)
    }
}
