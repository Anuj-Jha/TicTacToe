//
//  UserViewModel.swift
//  TicTacToe
//
//  Created by Anuj Jha  on 27/01/24.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published private var userModel = UserModel()
    
    var users: [User] {
        userModel.users
    }
    
    func addUser(user: User) {
        userModel.addUser(user: user)
    }
}
