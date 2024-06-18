//
//  UserModel.swift
//  TicTacToe
//
//  Created by Anuj Jha  on 27/01/24.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let name: String
}

struct UserModel {
    private(set) var users: [User] = []
    
    mutating func addUser(user: User) {
        users.append(user)
    }
}
