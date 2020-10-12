//
//  TodoItem.swift
//  TodoWithFirebase
//
//  Created by Yeojaeng on 2020/10/12.
//


/// Model for TodoItem
struct TodoItem: Codable {
    
    let id: String
    let name: String
    let completed: Bool
    
}
