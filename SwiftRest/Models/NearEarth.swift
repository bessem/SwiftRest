//
//  NearEarth.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

struct NearEarth: Codable {
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]
    
    enum CodingKeys: String, CodingKey {
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

extension NearEarth {
    var keys : [String] {
        return Array(nearEarthObjects.keys)
    }
    
    func objectForSection(section :Int) -> [NearEarthObject]{
        return nearEarthObjects[keys[section]]!
    }
}

struct NearEarthObject: Codable {
    let id, neoReferenceID, name: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let isPotentiallyHazardousAsteroid: Bool
    let isSentryObject: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case isSentryObject = "is_sentry_object"
    }
}
