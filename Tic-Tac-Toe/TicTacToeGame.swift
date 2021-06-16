//
//  TicTacToeGame.swift
//  Tic-Tac-Toe
//
//  Represents the model for the Tic-Tac-Toe game
//
//  Created by Austin Hyder on 6/15/21.
//

import Foundation

struct TicTacToeGame<CellContent> where CellContent: Equatable {
    private(set) var board: [GameCell] = Array<GameCell>()
    let xPiece: CellContent
    let oPiece: CellContent
    let blankPiece: CellContent
    private var xIsNext = true
    private(set) var gameOver = false
    
    mutating func placePiece(chosenCell: GameCell) {
        var winner: CellContent? = nil
        
        //Place piece
        if let chosenIndex = board.firstIndex(where: {$0.id == chosenCell.id}) {
            if xIsNext {
                self.board[chosenIndex].content = self.xPiece
            } else {
                self.board[chosenIndex].content = self.oPiece
            }
            xIsNext.toggle()
        }
        
        // Check and set winner accordingly
        if let potentialwinner = checkRowsForWinner() {
            winner = potentialwinner
        }
        if let potentialwinner = checkColumnsForWinner() {
            winner = potentialwinner
        }
        if let potentialwinner = checkDiagonalsForWinner() {
            winner = potentialwinner
        }
        
        //Final check for winner
        if winner != nil {
            print("We have a winner!")
            self.gameOver = true
        }
    }
    
    // TODO: Eventually rewrite winner determination logic to be faster
    // by only checking adjacent cells to the most recently populated cell
    
    private func checkRowsForWinner() -> CellContent? {
        return nil
    }
    
    private func checkColumnsForWinner() -> CellContent? {
        return nil
    }
    
    private func checkDiagonalsForWinner() -> CellContent? {
        return nil
    }
    
    init(xPiece: CellContent, oPiece: CellContent, blankPiece: CellContent) {

        // Initialize empty game board
        for index in 0..<9 {
            self.board.append(GameCell(content: blankPiece, id: index))
        }
        
        self.xPiece = xPiece
        self.oPiece = oPiece
        self.blankPiece = blankPiece
    }
    
    struct GameCell {
        var content: CellContent
        var isX = false
        var isO = false
        
        var populated: Bool {
            self.isX || self.isO
        }
        
        let id: Int
    }
}
