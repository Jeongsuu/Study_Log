//
//  ChatAppUser.swift
//  ChatAppMessenger
//
//  Created by Yeojaeng on 2020/10/14.
//

import Foundation

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let email: String

    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }

//    let profilePictureURL: String

}
