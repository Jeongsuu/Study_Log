//
//  UnsplashImage.swift
//  PinterestLayout
//
//  Created by Yeojaeng on 2020/10/18.
//

import Foundation

typealias Photos = [Photo]

struct Photo: Codable {
    let id: String
    let url: String
    
}

enum URLS: String, Codable {
    case raw, full, regular, small, thumb
}

