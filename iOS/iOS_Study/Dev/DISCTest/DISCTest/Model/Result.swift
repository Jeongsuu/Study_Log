//
//  Result.swift
//  DISCTest
//
//  Created by Yeojaeng on 2020/05/21.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import Foundation
import UIKit

struct Result: Codable {
    
    // Singleton design pattern
    static let shared: Result? = Result()
    
    // Instance Properties
    let d: Info
    let i: Info
    let s: Info
    let c: Info
    
    /// Custom Failable Initializer
    private init?() {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "Result") else { return nil }
        
        do {
            let result: Result = try JSONDecoder().decode(Result.self, from: dataAsset.data)
            // 가져온 데이터 값을 Result 타입으로 디코딩해라.
            self = result
        } catch {
            return nil
        }
    }
}



extension Result {
    
    struct Info: Codable {
        let title: String
        let typeDescription: String
    }
}
