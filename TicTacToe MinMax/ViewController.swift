//
//  ViewController.swift
//  TicTacToe MinMax
//
//  Created by Roberto Abreu on 25/7/16.
//  Copyright © 2016 homeappz. All rights reserved.
//

import UIKit

enum Player:Int{
    case Machine
    case Human
}

class ViewController: UIViewController {

    @IBOutlet var lblStatusPlayer: UILabel!
    @IBOutlet var vBoard: BoardView!
    @IBOutlet var btnReset: UIButton!
 
    var currentTurn:Player = Player.Machine
    var timer:NSTimer?
    var board:Board!
    var isChossingOption = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGame()
    }
    
    func setupGame(){
        board = Board()
        self.lblStatusPlayer.text = ""
        self.currentTurn = .Human
        self.isChossingOption = false
        self.vBoard.board = board
        
        let valueX:Int = Int(rand() % 3)
        let valueY:Int = Int(rand() % 3)
        self.board![valueX,valueY] = X()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update(){
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.vBoard.setNeedsDisplay()
            
            if self.board!.state() != GameState.Playing.rawValue{
                self.timer?.invalidate()
                self.lblStatusPlayer.text = GameState(rawValue: self.board!.state())?.description
                self.btnReset.hidden = false
            }else{
                self.btnReset.hidden = true
                if self.currentTurn == .Machine && !self.isChossingOption{
                    
                    self.lblStatusPlayer.text = "Turno de la máquina"
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                        self.isChossingOption = true
                        let move = MinMax.minMax(self.board!)
                        self.board![move.0,move.1] = X()
                        self.currentTurn = .Human
                        self.isChossingOption = false
                    })
                    
                    
                    
                }else if self.currentTurn == .Human{
                    self.lblStatusPlayer.text = "Tu turno"
                }
            }
        }
        

    }
    
    @IBAction func tapCell(sender: UITapGestureRecognizer) {
        if currentTurn == .Human{
            let touchPoint = sender.locationInView(self.vBoard)
            let numberCells = 3
            let sizeWidth = self.vBoard.bounds.width / CGFloat(numberCells)
            let sizeHeight = self.vBoard.bounds.height / CGFloat(numberCells)
            
            for i in 0..<numberCells{
                for j in 0..<numberCells{
                    let rect = CGRectMake(CGFloat(i) * sizeWidth, CGFloat(j) * sizeHeight, sizeWidth, sizeHeight)
                    if rect.contains(touchPoint) && self.board![i,j].identifier == DrawerIdentifier.Blank.rawValue{
                        self.board![i,j] = O()
                        self.currentTurn = .Machine
                        break
                    }
                }
            }
            
            
        }
    }
    
    @IBAction func resetGame(sender: AnyObject) {
        self.setupGame()
    }
 
}

