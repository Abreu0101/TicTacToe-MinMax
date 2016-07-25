//
//  Drawer.swift
//  TicTacToe MinMax
//
//  Created by Roberto Abreu on 25/7/16.
//  Copyright © 2016 homeappz. All rights reserved.
//

enum DrawerIdentifier:Int{
    case Humam = -1
    case Machine = 1
    case Blank = 0
    
    var stringRepresentation:String{
        switch self{
        case .Blank:
            return " "
        case .Machine:
            return "X"
        case .Humam:
            return "O"
        }
    }
}

protocol Drawer{
    var identifier:Int{get}
}
