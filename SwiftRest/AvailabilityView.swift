//
//  AvailabilityView.swift
//  SwiftRest
//
//  Created by user on 24/06/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import UIKit

@objc protocol AvailabilityViewDelegate: class {
    func titleWorksDay(section: Int) -> String
    func titleWorksShift(row: Int) -> String
}

@IBDesignable
class AvailabilityView: UIView {


    /// Color for busy shift
    @IBInspectable var busy : UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }

    /// Color for fair shift
    @IBInspectable var fair : UIColor = UIColor.yellow {
        didSet {
            setNeedsDisplay()
        }
    }

    /// Color for free shift
    @IBInspectable var free : UIColor = UIColor.green {
        didSet {
            setNeedsDisplay()
        }
    }

    /// Bottom draw spacing (can affect text draw)
    @IBInspectable var bottomSpacing : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// Start draw spacing (can affect text draw)
    @IBInspectable var startSpacing : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// Top draw spacing (can affect text draw)
    @IBInspectable var topSpacing : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// End draw spacing (can affect text draw)
    @IBInspectable var endSpacing : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// inter item spacing
    @IBInspectable var spacing : Int = 4 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// columns
    @IBInspectable var workDays : Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// rows
    @IBInspectable var shifts : Int = 4 {
        didSet {
            setNeedsDisplay()
        }
    }

    private var rect : CGRect {
        return self.frame
    }

    @IBOutlet weak var delegate: AvailabilityViewDelegate?

    /// the estimated height for matrix element
    fileprivate var estimatedHeightForCell: CGFloat {
        let exactHeight = rect.size.height - (topSpacing + bottomSpacing) - CGFloat((shifts + 1) * spacing)
        return floor(exactHeight / CGFloat(shifts))
    }

    /// the estimated width for matrix element
    fileprivate var estimatedWidthForCell: CGFloat {
        let exactWidth = rect.size.width - (startSpacing + endSpacing) - CGFloat((workDays + 1) * spacing)
        return floor(exactWidth / CGFloat(workDays))
    }

    override func draw(_ rect: CGRect) {
        /// draw label for work days
        for section in 0...workDays-1 {
            drawWorkdayLabel(section: section)
        }
        /// draw label for shifts
        for row in 0...shifts {
            drawShiftLabel(row: row)
        }
        /// draw rects matrix
        for section in 0...workDays-1 {
            for row in 0...shifts-1 {
                drawRect(row, section)
            }
        }
    }

    /// This method will handle draw of the matrix elements based on their coordinate
    ///
    /// - Parameters:
    ///   - row: the row index
    ///   - section: the section index
    ///   - fillColor: fill color with indicate the status
    fileprivate func drawRect(_ row: Int, _ section: Int, _ fillColor: UIColor = UIColor.blue) {

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(fillColor.cgColor)
        context.addPath(calculatePath(row, section))
        context.fillPath()
    }

    fileprivate func calculateHorizontalCoordinate(_ section: Int) -> CGFloat {
        return floor((estimatedWidthForCell * CGFloat(section)) + CGFloat(spacing * (section + 1)) + startSpacing)
    }

    fileprivate func calculateVerticalCoordinate(_ row: Int) -> CGFloat {
        return floor((estimatedHeightForCell * CGFloat(row)) + CGFloat(spacing * (row + 1)) + topSpacing)
    }

    fileprivate func calculatePath(_ row: Int, _ section: Int) -> CGPath {
        let horizontalCoord = calculateHorizontalCoordinate(section)
        let verticalCoord = calculateVerticalCoordinate(row)
        let rect = CGRect(x: horizontalCoord, y: verticalCoord, width: estimatedWidthForCell, height: estimatedHeightForCell)
        return UIBezierPath(rect: rect).cgPath
    }

    fileprivate func drawShiftLabel(row: Int) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]

        let title = delegate != nil ?
            delegate!.titleWorksShift(row: row) : "Shift \(row)"
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        let verticalCoord = calculateVerticalCoordinate(row) - attributedString.size().height
        let stringRect = CGRect(x: CGFloat(spacing), y: verticalCoord, width: startSpacing, height:estimatedHeightForCell)
        attributedString.draw(in: stringRect)
    }

    fileprivate func drawWorkdayLabel(section: Int) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]

        let title = delegate != nil ?
            delegate!.titleWorksDay(section: section) : "Day \(section)"
        let attributedString = NSAttributedString(string: title,
                                                  attributes: attributes)
        let horizontalCoord = calculateHorizontalCoordinate(section)
        let stringRect = CGRect(x: horizontalCoord, y:rect.size.height - CGFloat(bottomSpacing) , width: estimatedWidthForCell, height:bottomSpacing)
        attributedString.draw(in: stringRect)
    }
}
