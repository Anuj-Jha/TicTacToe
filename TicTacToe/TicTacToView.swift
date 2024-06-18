//
//  TicTacToView.swift
//  TicTacToe
//
//  Created by Anuj Jha  on 24/01/24.
//

import SwiftUI
import CoreData

enum SquareValue: String {
    case X, O, empty
}

class Square: ObservableObject {
    @Published var squareValue: SquareValue
    
    init(squareValue: SquareValue) {
        self.squareValue = squareValue
    }
}

class TicTacToeModel: ObservableObject {
    @Published var squares = [Square]()
    var winnerValue: SquareValue?
    
    init() {
        for _ in 0...8 {
            squares.append(Square(squareValue: .empty))
        }
    }
    
    func reset() {
        squares.removeAll()
        for _ in 0...8 {
            squares.append(Square(squareValue: .empty))
        }
    }
}

struct TicTacToView: View {
    @StateObject var tickTacToeModel = TicTacToeModel()
    @State var currentMove = SquareValue.empty
    @State var winnerFound = false
    var winningIndexes = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var body: some View {
        ZStack {
            LinearGradient(
                        gradient: Gradient(colors: [Color.red, Color.blue]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .edgesIgnoringSafeArea(.all)
            VStack {
                heading
                if currentMove != .empty {
                    squares
                    resetButton
                }
                
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .alert(isPresented: $winnerFound) {
            Alert(title: Text("Game Finish!"), message: Text("Congratulations \(tickTacToeModel.winnerValue!.rawValue)"), dismissButton: .default(Text("Okay"), action: {
                tickTacToeModel.reset()
                currentMove = .empty
            }))
        }
    }
    
    var heading: some View {
        VStack {
            
            if currentMove == .empty {
                
                VStack {
                    Text("Select First Player")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    HStack {
                        Button {
                            tickTacToeModel.reset()
                            currentMove = .X
                        } label: {
                            Capsule()
                                .overlay(
                                    Text("X")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .bold()
                                )
                                .foregroundColor(.black)
                                .frame(width: 100 ,height: 100)
                                .shadow(color: .white ,radius: 10)
                        }
                        
                        Button {
                            tickTacToeModel.reset()
                            currentMove = .O
                        } label: {
                            Capsule()
                                .overlay(
                                    Text("O")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .bold()
                                )
                                .foregroundColor(.black)
                                .frame(width: 100 ,height: 100)
                                .shadow(color: .white ,radius: 10)
                        }
                    }
                }.padding()
            } else {
                Text("TicTacToe")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom)
                    .foregroundColor(.white)
                
                Text("Next Move: \(currentMove.rawValue)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
    
    var squares: some View {
        VStack {
            ForEach(0..<tickTacToeModel.squares.count/3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        let index = row*3+col
                        Button {
                            makeMove(index: index)
                        } label: {
                            SquareView(square: tickTacToeModel.squares[index], action: {self.makeMove(index: index)})
                        }
                    }
                }
            }
        }
    }
    
    private func makeMove(index: Int) {
        if tickTacToeModel.squares[index].squareValue == .empty {
            tickTacToeModel.squares[index] = Square(squareValue: currentMove)
            currentMove = currentMove == .X ? .O : .X
            if checkWinner() {
                winnerFound = true
            }
        }
    }
    
    private func checkWinner() -> Bool {
        var winnerFound = false
        for winningIndex in winningIndexes {
            let winner = checkIndexes(indexs: winningIndex)
            if winner.0 == true {
                winnerFound = true
                tickTacToeModel.winnerValue = winner.1
                break
            }
        }
        return winnerFound
    }
    
    private func checkIndexes(indexs: [Int]) -> (Bool, SquareValue?) {
        var winner: (Bool, SquareValue?) = (false, nil)
        guard indexs.count > 0 else { return winner }
        let squareValue = tickTacToeModel.squares[indexs.first!].squareValue
        if squareValue != .empty {
            var allSame = true
            for index in indexs {
                if tickTacToeModel.squares[index].squareValue != squareValue {
                    allSame = false
                    break
                }
            }
            if allSame {
                winner = (true, squareValue)
            }
        }
        
        return winner
    }
    
    var resetButton: some View {
        Button {
            tickTacToeModel.reset()
            currentMove = .empty
        } label: {
            Text("Reset")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
        }
    }
    
}

struct SquareView: View {
    @ObservedObject var square: Square
    var action: () -> Void
    var body: some View {
        Button {
            self.action()
        } label: {
            Capsule()
                .overlay(
                    Text("\(square.squareValue == .empty ? "" : square.squareValue.rawValue)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                )
                .foregroundColor(.black)
                .frame(width: 100 ,height: 100)
                .shadow(color: .white ,radius: 10)
        }

    }
    
    func makeMove() {
        
    }
}

struct TicTacToView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToView()
    }
}
