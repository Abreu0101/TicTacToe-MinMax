//
//  MinMax.swift
//  TicTacToe MinMax
//
//  Created by Roberto Abreu on 25/7/16.
//  Copyright © 2016 homeappz. All rights reserved.
//

class MinMax{

    static func minMax(board:Board)->(Int,Int){
        var movement:(Int,Int) = (0,0)
        
        func minMaxHelper(turnPlayer:Int,board:Board)->Int{
            if board.state() != GameState.Playing.rawValue{
                return board.state()
            }
            
            var scores:[Int] = []
            var moves:[(Int,Int)] = []
            
            for i in 0..<3{
                for j in 0..<3{
                    if board[i,j].identifier == DrawerIdentifier.Blank.rawValue{
                        let copyBoard = Board(board: board)
                        copyBoard[i,j] = turnPlayer == 0 ? X() : O()
                        scores.append(minMaxHelper(1 - turnPlayer, board: copyBoard))
                        moves.append((i,j))
                    }
                }
            }
            
            //Turn Machine
            if turnPlayer == 0{
                if let score = scores.maxElement(){
                    let index = scores.indexOf(score)
                    movement = moves[index!]
                    return score
                }
            }else{
                if let score = scores.minElement(){
                    let index = scores.indexOf(score)
                    movement = moves[index!]
                    return score
                }
            }
            
            return 0
            
        }
        
        minMaxHelper(0, board: board)
        return movement
    }
    
}