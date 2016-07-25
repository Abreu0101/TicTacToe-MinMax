//
//  Board.swift
//  TicTacToe MinMax
//
//  Created by Roberto Abreu on 25/7/16.
//  Copyright © 2016 homeappz. All rights reserved.
//

enum GameState:Int{
    case MachineWin = 1
    case HumanWin = -1
    case Playing = 2
    case Draw = 0
}

class Board{
    
    var list:[[Drawer]]
    
    init(board:Board? = nil){
        list = []
        for i in 0..<3{
            var rowList:[Drawer] = []
            for j in 0..<3{
                if let board = board{
                    rowList.append(board[i,j])
                }else{
                    rowList.append(Blank())
                }
            }
            list.append(rowList)
        }
    }
    
    subscript(row:Int,col:Int)->Drawer{
        get{
            return list[row][col]
        }
        
        set{
            self.list[row][col] = newValue
        }
    }
    
    func state()->Int{
        
        //Check Horizontal
        for i in 0..<3{
            if self[0,i].identifier != DrawerIdentifier.Blank.rawValue && self[0,i].identifier == self[1,i].identifier && self[1,i].identifier == self[2,i].identifier{
                return self[0,i].identifier
            }
        }
        
        //Check Vertical
        for i in 0..<3{
            if self[i,0].identifier != DrawerIdentifier.Blank.rawValue && self[i,0].identifier == self[i,1].identifier && self[i,1].identifier == self[i,2].identifier{
                return self[i,0].identifier
            }
        }
        
        //Check Principal Diagonal
        if self[0,0].identifier != DrawerIdentifier.Blank.rawValue && self[0,0].identifier == self[1,1].identifier && self[1,1].identifier == self[2,2].identifier{
            return self[0,0].identifier
        }
        
        //Check Secondary Diagonal
        if self[0,2].identifier != DrawerIdentifier.Blank.rawValue && self[0,2].identifier == self[1,1].identifier && self[1,1].identifier == self[2,0].identifier{
            return self[0,2].identifier
        }
        
        for i in 0..<3{
            for j in 0..<3{
                if self[i,j].identifier == 0{
                    return GameState.Playing.rawValue
                }
            }
        }
        
        return GameState.Draw.rawValue
    }
    
    func printBoard(){
        for i in 0..<3{
            var valueToPrint = ""
            for j in 0..<3{
                valueToPrint += "\(DrawerIdentifier(rawValue: self[i,j].identifier)!.stringRepresentation)\t"
            }
            print(valueToPrint)
        }
    }
    
}
