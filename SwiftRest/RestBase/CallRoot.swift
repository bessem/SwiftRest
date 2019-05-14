//
//  CallRoot.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

/**
 # it looks gorgious this way base url as scheme+host endpoint as path query items you know
 
 ## CallRoot
 
 1. Scheme (Http, Https...)
 2. Host also know as base url
 3. Path also called end point
 4. QueryItems (i.e) : ?q=search&detaild=true...
 
 */
struct CallRoot {
    let scheme: String
    let host : String
    let path: String
    let queryItems: [URLQueryItem]?
}
