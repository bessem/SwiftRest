//
//  StarView.swift
//  SwiftRest
//
//  Created by user on 01/08/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: UIView {

    @IBInspectable var strokeColor : UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var fillColor : UIColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }


    @IBInspectable var isFilled : Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }


    override func draw(_ rect: CGRect){
        // constants
        let w = CGFloat(self.frame.width)
        let r = CGFloat(w/2.0)
        let theta = 2.0 * CGFloat.pi * (2.0 / 5.0)
        let flip = CGFloat(-1.0) // flip vertically (default star representation)

        // drawing center for the star
        let xCenter = r

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(fillColor.cgColor)
        context.setStrokeColor(strokeColor.cgColor)

        context.move(to: CGPoint(x: xCenter, y: r * flip + r))

        // draw the necessary star lines
        for k in 1...5 {
            let x = r * sin(CGFloat(k) * theta)
            let y = r * cos(CGFloat(k) * theta)
            context.addLine(to: CGPoint(x: x + xCenter,y:  y * flip + r))
        }

        // draw current star
        context.closePath()
        if isFilled {
            context.fillPath()

        } else {
            context.strokePath()
        }
    }


}
