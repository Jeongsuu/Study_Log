//
//  EndPoint.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation

// protocol for EndPoint
protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var urlparam: [URLQueryItem] { get }

}

// Default Implementation
extension EndPoint {

    var urlComponent: URLComponents {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path = path
        urlComponent?.queryItems = urlparam

        return urlComponent!
    }

    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}

enum Order: String {
    case polular
    case latest
    case oldest
}

enum UnsplashEndPoint: EndPoint {
    // api.unsplash.com/photos
    case photos(client_id: String, orderBy: Order)

    var baseURL: String {
        return "https://api.unsplash.com"
    }

    var path: String {
        switch self {
        case .photos:
            return "/photos"
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
}
