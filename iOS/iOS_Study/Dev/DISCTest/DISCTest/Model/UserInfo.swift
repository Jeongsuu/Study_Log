//
//  UserInfo.swift
//  DISCTest
//
//  Created by Yeojaeng on 2020/05/21.
//  Copyright © 2020 Yeojaeng. All rights reserved.
//

import Foundation

class UserInfo {
    
    // for Singleton design pattern
    static let shared: UserInfo = UserInfo()
    
    // Instance Properties
    var name: String!
    
    let score: Score = Score()              // Score 객체 생성
    
    var hightestScoreResult: Result.Info? {     // Computed Property
        let hightest: Int = max(self.score.d, self.score.i, self.score.s, self.score.c)
        switch hightest{
        case self.score.d:
            return Result.shared?.d
        case self.score.i:
            return Result.shared?.i
        case self.score.s:
            return Result.shared?.s
        default:
            return Result.shared?.c
        }
    }
    
    var scorePercetageText: String {
        
        let sum: Double = Double(self.score.d + self.score.i + self.score.s + self.score.c)
        let percentageD = Double(self.score.d) / sum*100
        let percentageI = Double(self.score.i) / sum*100
        let percentageS = Double(self.score.s) / sum*100
        let percentageC = Double(self.score.c) / sum*100
        
        return String(format: "D : %.01f%%, I : %.01f%%, S : %.01f%%, C : %.01f%%",
        percentageD,
        percentageI,
        percentageS,
        percentageC)
    }
}

extension UserInfo {
    
    class Score {
        var d: Int = 0
        var i: Int = 0
        var s: Int = 0
        var c: Int = 0
    }
    
    func reset() {
        self.score.d = 0
        self.score.i = 0
        self.score.s = 0
        self.score.c = 0
        self.name = nil
    }
    
    enum ScoreType {
        case d, i, s, c
    }
}
