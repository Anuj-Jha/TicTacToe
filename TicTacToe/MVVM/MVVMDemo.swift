//
//  MVVMDemo.swift
//  TicTacToe
//
//  Created by Anuj Jha  on 27/01/24.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        List(userViewModel.users) { user in
            VStack {
                Text(user.name)
                Text("\(user.id)")
            }
        }
        .navigationTitle(Text("Users"))
        .toolbar {
            Button(action: {
                userViewModel.addUser(user: User(id: UUID(),name: "User"))
            }) {
                Image(systemName: "plus")
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
