//
//  BubbleView.swift
//  SwiftRest
//
//  Created by user on 12/06/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import UIKit

@IBDesignable
class BubbleView: UIView {

    @IBInspectable var bubbleColor : UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var bubbleStrokeColor : UIColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(bubbleColor.cgColor)
        context.setStrokeColor(bubbleStrokeColor.cgColor)
        context.addPath(dialogBezierPathWithFrame(frame: rect).cgPath)
        
        context.fillPath()
        
        context.addPath(topLine(frame: rect).cgPath)
        context.addPath(bottomLine(frame: rect).cgPath)
        context.strokePath()
    }
    
    func dialogBezierPathWithFrame(frame: CGRect, arrowLength: CGFloat = 20.0) -> UIBezierPath {
        // 1. We need 7 points for our Bezier path
        
        
        let midX = frame.midX
        let point1 = CGPoint(x: frame.minX,
                             y: frame.minY)
        
        let point2 = CGPoint(x: frame.maxX,
                             y: frame.minY)
        
        let point3 = CGPoint(x: frame.maxX,
                             y: frame.maxY - arrowLength)
        
        let point4 = CGPoint(x: midX + (arrowLength / 2),
                             y: frame.maxY - arrowLength)
        
        let point5 = CGPoint(x: midX,
                             y: frame.maxY)
        
        let point6 = CGPoint(x: midX - (arrowLength / 2),
                             y: frame.maxY - arrowLength)
        
        let point7 = CGPoint(x: frame.minX,
                             y: frame.maxY - arrowLength)
        
        // 2. Build our Bezier path
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.addLine(to: point5)
        path.addLine(to: point6)
        path.addLine(to: point7)
        path.close()
        
        return path
    }
    
    func bottomLine(frame: CGRect, arrowLength: CGFloat = 20.0)-> UIBezierPath {
        // 1. We need 5 points for our Bezier path
        
        
        let midX = frame.midX
        
        let point1 = CGPoint(x: frame.maxX,
                             y: frame.maxY - arrowLength)
        
        let point2 = CGPoint(x: midX + (arrowLength / 2),
                             y: frame.maxY - arrowLength)
        
        let point3 = CGPoint(x: midX,
                             y: frame.maxY)
        
        let point4 = CGPoint(x: midX - (arrowLength / 2),
                             y: frame.maxY - arrowLength)
        
        let point5 = CGPoint(x: frame.minX,
                             y: frame.maxY - arrowLength)
        
        // 2. Build our Bezier path
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.addLine(to: point5)
        path.stroke()
        
        return path
    }
    
    func topLine(frame: CGRect)-> UIBezierPath {
        
        let point1 = CGPoint(x: frame.minX,
                             y: frame.minY )
        
        let point2 = CGPoint(x: frame.maxX,
                             y: frame.minY)

        
        // 2. Build our Bezier path
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.stroke()
        
        return path
    }
}
