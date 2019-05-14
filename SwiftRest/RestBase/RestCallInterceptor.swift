//
//  RestCallInterceptor.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

struct RestCallInterceptor {
    func intercept(_ request : inout URLRequest) {
        dump(request.allHTTPHeaderFields)
    }
}
