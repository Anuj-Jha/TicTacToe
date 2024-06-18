//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Anuj Jha  on 24/01/24.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
