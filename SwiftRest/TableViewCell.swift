//
//  TableViewCell.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var nearEarthObject : NearEarthObject? {
        didSet {
            self.textLabel?.attributedText = nearEarthObject?.title
            self.imageView?.image = nearEarthObject?.infoImage
        }
    }
}

/// MARK - VM ext

extension NearEarthObject {
    
    var hazardColor : UIColor{
        return isPotentiallyHazardousAsteroid ?
            UIColor(red: 190/255, green: 10/255, blue: 50/255, alpha: 1) :
            UIColor(red: 10/255, green: 190/255, blue: 50/255, alpha: 1)
    }
    
    /// title color indicate is isPotentiallyHazardousAsteroid or not...
    // trigger build
    var infoImage : UIImage? {
        let emoji = isPotentiallyHazardousAsteroid ? "☠️" : "☮️"
        
        let size = CGSize(width: 35, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        emoji.draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    var title : NSAttributedString {
        
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : hazardColor];
        let attributedString = NSAttributedString(string: name , attributes: attributedStringColor)
        
        return attributedString
        
    }
    
}
