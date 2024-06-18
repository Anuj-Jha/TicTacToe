//
//  HomeView.swift
//  TicTacToe
//
//  Created by Anuj Jha  on 27/01/24.
//

import SwiftUI

struct HomeView: View {
    let items = ["MVVM", "TicTacToe"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    NavigationLink {
                        if index == 0 {
                            UserView()
                        } else {
                            TicTacToView()
                        }
                    } label: {
                        Text("\(items[index])")
                    }
                }
                .navigationTitle(Text("Items"))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
