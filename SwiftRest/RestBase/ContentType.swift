//
//  ContentType.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

/**
 # Enum for basic content type
 
 ## ContentType
 
 - application/json
 - multipart/form-data
 - application/x-www-form-urlencoded
 
 */
enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
    case urlencoded = "application/x-www-form-urlencoded"
}
