//
//  RippleLoader.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation
import UIKit

class RippleLoader: UIView {
    
    @IBInspectable var stroke : CGFloat = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var strokeColor : UIColor = UIColor.blue
    
    @IBInspectable var progress1 : CGFloat = _balMinProgress {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var progress2 : CGFloat = _balMaxProgress {
        didSet {
            setNeedsDisplay()
        }
    }
    
    fileprivate var up : Bool = true
    
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
    
    private var prop1Color : UIColor {
        get{
            return strokeColor.withAlphaComponent(1-(progress1/_balMaxProgress))
        }
    }
    
    private var prop1Radius : CGFloat {
        get{
            return drawRadius * (progress1/_balMaxProgress)
        }
    }
    
    private var prop2Color : UIColor {
        get{
            return strokeColor.withAlphaComponent(1-(progress2/_balMaxProgress))
        }
    }
    
    private var prop2Radius : CGFloat {
        get{
            return drawRadius * (progress2/_balMaxProgress)
        }
    }
    
    func radianOf(degree : CGFloat) -> CGFloat{
        return CGFloat(((2 * π) / _balMaxProgress) * degree)
    }
    
    override func draw(_ rect: CGRect) {
        drawOuterCircle()
    }
    
    
    fileprivate func drawCircle(_ context: CGContext, radius: CGFloat, color : UIColor) {
        
        // Set the circle outerline-width
        context.setLineWidth(stroke);
        
        // Set the circle outerline-colour
        context.setStrokeColor(color.cgColor)
        
        // Create Circle
        
        context.addArc(center: drawCenter,
                       radius: radius,
                       startAngle: radianOf(degree: _balMaxProgress),
                       endAngle: radianOf(degree: _balMinProgress),
                       clockwise: true)
        
        // Draw
        context.strokePath()
    }
    
    fileprivate func drawOuterCircle() {
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        drawCircle(context, radius: prop1Radius, color: prop1Color)
        drawCircle(context, radius: prop2Radius, color: prop2Color)
        
    }
    
    func startAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
    }
    
    @objc func loop(){
        if up {
            if progress1 >= _balMaxProgress {
                up = false
                strokeColor = .random
            }else{
                progress1 += 5
                progress2 -= 5
            }
            
        }else{
            if progress1 <= _balMinProgress {
                up = true
                strokeColor = .random
            }else{
                progress1 -= 5
                progress2 += 5
            }
        }
    }
    
    func endAnimation() {
        guard let _ = timer else {return}
        timer!.invalidate()
        timer = nil
    }
    
}

