//
//  BaseViewController.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var loaderHolder : UIView?
    var didLayoutSubviewsOnce : Bool = false
    
    func startLoading(_ onView : UIView?) {
        guard let targetView = onView != nil ? onView : self.view else {
            return
        }
        loaderHolder = UIView(frame: targetView.frame)
        loaderHolder!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let loader = BullCircleLoader(frame: CGRect(x:0, y: 0, width: 50, height: 50))
        loader.center = loaderHolder!.center
        loader.backgroundColor = .clear
        loaderHolder!.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        loaderHolder!.addSubview(loader)
        targetView.addSubview(loaderHolder!)
        loader.startAnimation()
    }
    
    func stopLoading() {
        if loaderHolder != nil {
            loaderHolder?.removeFromSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        if !didLayoutSubviewsOnce {
            didLayoutSubviewsOnce = true
            didLayoutSubviewsForTheFirstTime()
        }
    }
    
    func didLayoutSubviewsForTheFirstTime(){
        
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        print("Touches cancelled");
    }
}
