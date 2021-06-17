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
    private(set) var winner: CellContent? = nil
    
    mutating func placePiece(chosenCell: GameCell) {
        var winner: CellContent? = nil
        
        //Place piece
        if let chosenIndex = board.firstIndex(where: {$0.id == chosenCell.id}) {
            
            //Check if valid placement
            if self.board[chosenIndex].populated || self.gameOver {
                return
            }
            
            if xIsNext {
                self.board[chosenIndex].content = self.xPiece
                self.board[chosenIndex].isX = true
            } else {
                self.board[chosenIndex].content = self.oPiece
                self.board[chosenIndex].isO = true
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
            self.winner = winner
            self.gameOver = true
        }
    }
    
    mutating func newGame() {
        
        // Reset board
        for index in 0..<9 {
            board[index].content = blankPiece
            board[index].isX = false
            board[index].isO = false
        }
        
        // Clear winner
        self.winner = nil
        
        // Reset turn to x first
        self.xIsNext = true
        
        // Update game over
        self.gameOver = false
    }
    
    // TODO: Eventually rewrite winner determination logic to be faster
    // by only checking adjacent cells to the most recently populated cell
    
    private func checkRowsForWinner() -> CellContent? {
        for row in stride(from: 0, through: 6, by: 3) {
            if self.board[row].populated &&
                self.board[row].content == self.board[row+1].content &&
                self.board[row+1].content == self.board[row+2].content
            {
                return self.board[row].content
            }
        }
        return nil
    }
    
    private func checkColumnsForWinner() -> CellContent? {
        for column in 0..<3 {
            if self.board[column].populated &&
                self.board[column].content == self.board[column+3].content &&
                self.board[column+3].content == self.board[column+6].content
            {
                return self.board[column].content
            }
        }
        return nil
    }
    
    private func checkDiagonalsForWinner() -> CellContent? {
        if self.board[0].populated &&
            self.board[0].content == self.board[4].content &&
            self.board[4].content == self.board[8].content
        {
            return self.board[0].content
        }
        
        else if self.board[2].populated &&
            self.board[2].content == self.board[4].content &&
            self.board[4].content == self.board[6].content
        {
            return self.board[2].content
        }
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
    
    struct GameCell: Identifiable {
        var content: CellContent
        var isX = false
        var isO = false
        
        var populated: Bool {
            self.isX || self.isO
        }
        
        let id: Int
    }
}
