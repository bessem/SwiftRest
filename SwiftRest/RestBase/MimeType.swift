//
//  MimeType.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

/**
 # An easy to use MimeType wrapper
 
 ## MimeType
 
 1. filename image.jpg , image.png ...
 2. mimeType image/jpg , image/png ...
 3. data it can be some UIImageJPEGRepresentation or any other data ...
 
 */
struct MimeType {
    let filename: String
    let mimeType : String
    let data: Data
}
