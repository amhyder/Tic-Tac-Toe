//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Austin Hyder on 6/15/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: StandardGame
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Tic-Tac-Toe!")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Spacer()
            LazyVGrid(columns: columns) {
                ForEach(viewModel.board) { cell in
                    CellView(cell: cell)
                        .onTapGesture {
                            viewModel.choose(cell)
                        }
                }
            }
            Spacer()
            
            if viewModel.winner != "" {
                Text("The winner is \(viewModel.winner)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Button("New Game", action: {viewModel.newGame()})
            } else {
                Text("Game in progress...")
            }
        }
        .padding()
    }
}

struct CellView: View {
    var cell: TicTacToeGame<String>.GameCell
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(lineWidth: 3)
                .aspectRatio(1, contentMode: .fit)
            Text("\(cell.content)")
                .font(.title)
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = StandardGame()
        
        ContentView(viewModel: game)
            .previewDevice("iPhone 11")
    }
}
