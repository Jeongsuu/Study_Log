//
//  UnsplashClient.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation

class UnsplashClient: APIClient {
    
    static let baseURL = "https://api.unsplash.com"
    static let apiKey = "Vn1qhRLQEZFSuC5c_I_ywfdKvuFWbBC-6zYeqEntZfo"
    
    func fetch(with endPoint: UnsplashEndPoint, completion: @escaping (Result<Photos, Error>) -> Void) {
        let request = endPoint.request
        get(with: request, completion: completion)
    }
}
