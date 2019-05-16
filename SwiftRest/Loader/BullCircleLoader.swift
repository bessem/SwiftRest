//
//  BullCircleLoader.swift
//  SwiftRest
//
//  Created by user on 16/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation
import UIKit

class BullCircleLoader : UIView {
    
    @IBInspectable var numberOfDots : Int = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var strokeColor : UIColor = UIColor.blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var progress : Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    fileprivate var timer : Timer?
    
    private var rect : CGRect {
        get{
            return self.frame
        }
    }
    
    private var drawCenter : CGPoint {
        get{
            return CGPoint(x: rect.width/2, y: rect.height/2)
        }
    }
    
    private var drawRadius : CGFloat {
        get{
            return min((rect.width/2), (rect.height/2)) * 0.8
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        print("start draw progress = \(progress)")
        for i in 0...numberOfDots-1 {
            print("circle at index = \(i)")
            drawCircle(context, radius: calculateRadius(index: i), center : calculateCenter(index: i))
        }
        print("end draw")
    }
    
    fileprivate func drawCircle(_ context: CGContext, radius : CGFloat, center : CGPoint) {
        
        print("radius = \(radius)")
        
        
        // Set the circle outerline-width
        
        // Set the circle outerline-colour
        context.setFillColor(strokeColor.cgColor)
        
        // Create Circle
        
        
        context.addArc(center: center,
                       radius: radius,
                       startAngle: 2 * .pi,
                       endAngle: 0,
                       clockwise: true)
        
        // Draw
        context.fillPath()
    }
    
    
    func calculateRadius(index : Int) -> CGFloat {
        let propIndex = CGFloat((index + progress) % numberOfDots)
        
        return CGFloat( ( propIndex + 1 ) * 3/4 )
    }
    
    func calculateCenter(index : Int) -> CGPoint {
        
        let theta = ((2 * .pi) / CGFloat(numberOfDots)) * CGFloat(index)
        
        let x = cos(theta) * drawRadius
        let y = sin(theta) * drawRadius
        
        return CGPoint(x: drawCenter.x + x, y: drawCenter.y + y)
    }
    
    func startAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
    }
    
    @objc func loop() {
        
        if progress >= numberOfDots {
            progress = 1
        }else{
            progress += 1
        }
        
    }
    
    func endAnimation() {
        guard let _ = timer else {return}
        timer!.invalidate()
        timer = nil
    }
    
}
