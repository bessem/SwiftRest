//
//  NearEarthListService.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

class NearEarthListService {
    
    
    static let shared = NearEarthListService()
        
    //restricted, yep singleton
    private init(){}
    
    /// lazy var & lazy me
    lazy var urlSession: URLSession = {
        return URLSession.shared
    }()
    
    @discardableResult
    func ping(completion : @escaping (Result<NearEarth, GenericError>) -> Void)  -> URLSessionDataTask? {
        return NearEarthListCall().execute(urlSession , completion: completion)
    }
    
    
    func mock(completion : @escaping (Result<NearEarth, GenericError>) -> Void){
        NearEarthListCall().mock("_rest_v1_feed", completion: completion)
    }
    
}
