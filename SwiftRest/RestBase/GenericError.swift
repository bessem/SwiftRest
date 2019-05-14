//
//  GenericError.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

/**
 # GenericError enum (to make it more readable / easy to use)
 # dev u can see it like a GUI i know ;)
 
 ## GenericError
 
 - networkError
 - malformedUrl
 - dataNotFound
 - canceled
 - jsonParsingError
 - invalidStatusCode
 
 */

enum GenericError: Error {
    case networkError(Error)
    case malformedUrl
    case badData
    case unsupportedOperation
    case dataNotFound
    case canceled
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}
