//
//  ViewController.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var availabilityView: AvailabilityView!
    let days = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"]
    let hours = ["18:00", "16:00", "15:00", "13:00", "9:00"]
    @IBOutlet weak var loader: RippleLoader!
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimation()
    }
}

extension ViewController: AvailabilityViewDelegate {
    func titleWorksDay(section: Int) -> String {
        return days[section]
    }

    func titleWorksShift(row: Int) -> String {
        return hours[row]
    }
}





