//
//  BoardView.swift
//  TicTacToe MinMax
//
//  Created by Roberto Abreu on 25/7/16.
//  Copyright © 2016 homeappz. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    var board:Board?{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        if let board = board{
            let width = self.bounds.width
            let height = self.bounds.height
            
            let numberOfCells:Int = 3
            
            let sizeWidth = width / CGFloat(numberOfCells)
            let sizeHeight = height / CGFloat(numberOfCells)
            
            let context = UIGraphicsGetCurrentContext()
            for i in 0..<numberOfCells{
                for j in 0..<numberOfCells{
                    let rect = CGRectMake(CGFloat(i) * sizeWidth, CGFloat(j) * sizeWidth, sizeWidth, sizeHeight)
                    
                    CGContextSetLineWidth(context, 1.3)
                    CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                    CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
                    CGContextStrokeRect(context, rect)
                    let valueString = DrawerIdentifier(rawValue: board[i,j].identifier)?.stringRepresentation
                    
                    CGContextSetLineWidth(context, 1.2)
                    CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                    CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
                    
                    
                    let sizeLabel = (valueString! as NSString).sizeWithAttributes([NSFontAttributeName:UIFont(name: "Helvetica", size: 60.0)!])
                    
                    (valueString! as NSString).drawAtPoint(CGPoint(x: CGRectGetMidX(rect) - sizeLabel.width / 2, y: CGRectGetMidY(rect) - sizeLabel.height / 2), withAttributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 60.0)!])
                    
                    
                    //(valueString! as NSString).drawInRect(offsetRect, withAttributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 60.0)!])
                }
            }
        }

    }


}
