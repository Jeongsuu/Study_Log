//
//  EndPoint.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation

/// EndPoint 프로토콜 정의
protocol EndPoint {
    static var baseURL: String { get }
    var path: String { get }
    var urlparam: [URLQueryItem] { get }

}

/// 프로토콜 초기 구현
extension EndPoint {

    static var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    // request시 이용할 url을 위한 url 구성
    var urlComponent: URLComponents {
        var urlComponent = URLComponents(string: Self.baseURL)
        urlComponent?.path = path
        urlComponent?.queryItems = urlparam

        return urlComponent!
    }

    // 요청 보낼 URL
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}

/// 정렬 기준 열거형
enum Order: String {
    case polular
    case latest
    case oldest
}

/// UnsplashEndPoint 열거형
enum UnsplashEndPoint: EndPoint {

    // 열거형 내에서 사용할 변수
    var path: String {
        switch self {
        case .photos:
            return "/photos" // https://api.unsplash.com/photos
        }
    }

    var urlparam: [URLQueryItem] {
        switch self {
        case .photos(let id, let orderBy):
            return [
                URLQueryItem(name: "client_id", value: id),
                URLQueryItem(name: "order_by", value: orderBy.rawValue)
            ]
        }
    }

    case photos(client_id: String, orderBy: Order)
}
