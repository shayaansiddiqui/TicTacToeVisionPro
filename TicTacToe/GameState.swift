//
//  GameState.swift
//  TicTacToe
//
//  Created by Shayaan Siddiqui on 7/11/23.
//

import Foundation


class GameState : ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtScore = 0
    @Published var crossScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"
    
    init()
    {
        resetBoard()
    }
    
    func turnText() -> String
    {
        return turn == Tile.Cross ? "Turn X" : "Turn O"
    }
    
    func placeTile(_ row: Int, _ column: Int)
    {
        // Check if board space is available to be used
        if(board[row][column].tile != Tile.Empty)
        {
            return
        }
        
        // Set the tile to X or O
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        
        if(checkForVictory())
        {
            if(turn == Tile.Cross)
            {
                // Add 1 to Cross score
                crossScore += 1
            } else {
                // Add 1 to Nought's score
                noughtScore += 1
            }
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"
            showAlert = true
            
        } else {
            // Taking Turns.
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        if(checkForDraw() && !checkForVictory())
        {
            alertMessage = "Draw"
            showAlert = true
        }
    }
    
    func isTurnTile(_ row: Int, _ column: Int) -> Bool
    {
        return board[row][column].tile == turn
    }
    
    func checkForVictory() -> Bool
    {
        // Vertical Victory
        if(isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0))
        {
            return true
        }
        if(isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1))
        {
            return true
        }
        if(isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2))
        {
            return true
        }
        
        // Horizontal Victory
        if(isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2))
        {
            return true
        }
        if(isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1 ,2))
        {
            return true
        }
        if(isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2))
        {
            return true
        }
        
        // Diagonal Victory
        if(isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2))
        {
            return true
        }
        if(isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2 ,0))
        {
            return true
        }
        return false
    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if(cell.tile == Tile.Empty)
                {
                    return false
                }
            }
        }
        return true
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
