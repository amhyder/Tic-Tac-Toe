//
//  StandardTicTacToeGame.swift
//  Tic-Tac-Toe
//
//  Represents the model-view for the Tic-Tac-Toe game
//
//  Created by Austin Hyder on 6/15/21.
//

import SwiftUI

class StandardGame: ObservableObject {
    
    static var xPiece = "❌"
    static var oPiece = "⭕️"
    static var blankPiece = ""
    
    static func createTicTacToeGame() -> TicTacToeGame<String> {
        TicTacToeGame<String>(xPiece: self.xPiece, oPiece: self.oPiece, blankPiece: self.blankPiece)
    }
    
    @Published private var model: TicTacToeGame<String> = createTicTacToeGame()
    
    var board: Array<TicTacToeGame<String>.GameCell> {
        return model.board
    }
    
    //MARK: - Intent(s)
    
    func choose(_ cell: TicTacToeGame<String>.GameCell) {
        model.placePiece(chosenCell: cell)
    }
}
