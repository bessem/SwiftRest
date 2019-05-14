//
//  NearEarthListCall.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

class NearEarthListCall : RestCall {
    
    var mimeTypeData: [MimeType]? = nil
    
    var httpMethod: HttpMethod = .GET
    
    var contentType: ContentType = .json
    
    var callRoot: CallRoot {
        return CallRoot(scheme: "https",
                        host: "www.neowsapp.com",
                        path: "/rest/v1/feed",
                        queryItems: [URLQueryItem(name: "detailed", value: "false")])
    }
    
    
    var bodyParams: [String : Any]? = nil
    
    typealias T = NearEarth
    
}
