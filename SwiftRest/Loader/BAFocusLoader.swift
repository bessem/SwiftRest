//
//  BALoader.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation
import UIKit

let _balMinProgress : CGFloat = 0.0

let _balMaxProgress : CGFloat = 360.0

let _balDefaultColor = UIColor(red: 0/255, green: 216/255, blue: 209/255, alpha: 1.0)

let π: CGFloat = .pi

class BALoader: UIView {
    
    @IBInspectable var stroke : CGFloat = 2.0
    
    @IBInspectable var strokeColor : UIColor = UIColor.blue
    
    @IBInspectable var progress : CGFloat = _balMinProgress {
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
    
    private var propColor : UIColor {
        get{
            return strokeColor.withAlphaComponent(1-(progress/_balMaxProgress))
        }
    }
    
    private var propRadius : CGFloat {
        get{
            return drawRadius * (progress/_balMaxProgress)
        }
    }
    
    private var propArc : CGFloat {
        get{
            return 90 * (progress/_balMaxProgress)
        }
    }
    
    func radianOf(degree : CGFloat) -> CGFloat{
        return CGFloat(((2 * π) / _balMaxProgress) * degree)
    }
    
    override func draw(_ rect: CGRect) {
        drawOuterCircle()
    }
    
    fileprivate func drawCircle(_ context: CGContext, startAngle: CGFloat, endAngle: CGFloat) {
        //1 - save original state
        context.saveGState()
        
        // Set the circle outerline-width
        context.setLineWidth(2.0);
        
        // Set the circle outerline-colour
        context.setStrokeColor(propColor.cgColor)
        
        // Create Circle
        
        context.addArc(center: drawCenter, radius: drawRadius, startAngle: radianOf(degree: startAngle), endAngle: radianOf(degree: endAngle), clockwise: true)
        
        // Draw
        context.strokePath()
        
        //8 - restore the original (draw over)
        context.restoreGState()
    }
    
    fileprivate func drawCircle(_ context: CGContext) {
        
        // Set the circle outerline-width
        context.setLineWidth(2.0);
        
        // Set the circle outerline-colour
        context.setStrokeColor(propColor.cgColor)
        
        // Create Circle
        
        context.addArc(center: drawCenter,
                       radius: propRadius,
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
        drawCircle(context, startAngle: progress + propArc, endAngle: progress )
        drawCircle(context)
        
    }
    
    func startAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
    }
    
    @objc func loop() {
        if up {
            if progress >= _balMaxProgress {
                up = false
                strokeColor = .random
            }else{
                progress += 5
            }
            
        }else{
            if progress <= _balMinProgress {
                up = true
                strokeColor = .random
            }else{
                progress -= 5
            }
        }
    }
    
    func endAnimation() {
        guard let _ = timer else {return}
        timer!.invalidate()
        timer = nil
    }
    
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

