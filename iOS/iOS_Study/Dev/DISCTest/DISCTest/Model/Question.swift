//
//  Question.swift
//  DISCTest
//
//  Created by Yeojaeng on 2020/05/21.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import Foundation
import UIKit

struct Question: Codable {
    
    let d: String
    let i: String
    let s: String
    let t: String
}

extension Question {
    
    static var all: [Question] = {          //Stored Property
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "Queestions") else { return []}
        // Questions 에셋에 담긴 모든 내용을 Question 타입의 자료형 배열에 모두 가져온다.
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        do {
            return try jsonDecoder.decode([Question].self, from:dataAsset.data)
            // dataAsset.data를 [Question].self 형식으로 디코딩해라
        } catch {
            return []
        }
    }()
}
