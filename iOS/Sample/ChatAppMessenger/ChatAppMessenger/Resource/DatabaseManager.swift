//
//  DatabaseManager.swift
//  ChatAppMessenger
//
//  Created by Yeojaeng on 2020/10/14.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {

    // Singleton
    static let shared = DatabaseManager()
//    private let dbReference = Database.database().reference()
    private let dbReference = DatabaseReference()

}

// MARK: - Account Management

extension DatabaseManager {

    /// email: [first_name, last_name] 타입으로 DB에 유저 등록
    /// - Parameter user: ChatAppuser 타입의 유저 모델
    public func insertUser(with user: ChatAppUser) {
        dbReference.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }

    /// 기존에 존재하는 유저인지 확인하는 함수
    /// - Parameters:
    ///   - email: 유저의 email 값으로 중복 여부 학인
    ///   - completion: Bool을 인자로 갖는 클로저 반환
    public func isUserExist(with email: String,
                            completion: @escaping ((Bool) -> Void)) {

        dbReference.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)       // 중복 데이터가 없는 경우 false 반환
                return
            }
            completion(true)            // 중복 데이터가 존재할 경우 true 반환
        }
    }
}
