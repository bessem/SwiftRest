//
//  RequestBuilder.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

let RestCall_RequestBuilderBoundary = "Boundary-\(UUID().uuidString)"

import Foundation

/**
 Helper struct to handle request buiding based on info such as
 Based on call (httpMethod and contentType)
 the helper generate the URLRequest to be executed:
 -   build<T : RestCall>(_ call : T) -> URLRequest
 *   buildGet<T : RestCall>(_ call : T) -> URLRequest
 *   buildPost<T : RestCall>(_ call : T) -> URLRequest
 
 -   buildUrlEcodedPostUpdateRequest<T : RestCall>( _ call: T) -> URLRequest
 -   buildJsonPostUpdateRequest<T : RestCall>( _ call: T) -> URLRequest
 -   buildMultiPartFormDataPostUpdateRequest<T : RestCall>( _ call: T) -> URLRequest
 
 *   buildUpdate<T : RestCall>(_ call : T) -> URLRequest
 
 -   buildUrlEcodedPostUpdateRequest<T : RestCall>( _ call: T) -> URLRequest
 -   buildJsonPostUpdateRequest<T : RestCall>( _ call: T) -> URLRequest
 -   buildMultiPartFormDataPostUpdateRequest<T : RestCall>( _ call: T) -> URLRequest
 
 *   buildDelete<T : RestCall>(_ call : T) -> URLRequest
 
 **/
struct RequestBuilder {
    /**
     Initializes a new URLRequest with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    static func build<T : RestCall>(_ call : T) throws -> URLRequest{
        switch call.httpMethod {
        case .GET:
            return RequestBuilder.buildGet(call)
        case .POST:
            return try RequestBuilder.buildPost(call)
        case .UPDATE:
            return try RequestBuilder.buildUpdate(call)
        case .DELETE:
            return RequestBuilder.buildDelete(call)
        }
    }
}



extension RequestBuilder {
    /**
     Build a new GET URLRequest with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    static func buildGet<T : RestCall>(_ call : T) -> URLRequest{
        var request = URLRequest(url: call.url)
        request.httpMethod = call.httpMethod.rawValue //set http method as GET
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Accept")
        return request
    }
    
    /**
     Build a new POST URLRequest with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    static func buildPost<T : RestCall>(_ call : T) throws -> URLRequest{
        switch call.contentType {
            
        case .json:
            return try buildJsonPostUpdateRequest(call)
            
        case .multipart:
            return try buildJsonPostUpdateRequest(call)
            
        case .urlencoded:
            return try buildUrlEcodedPostUpdateRequest(call)
            
        }
    }
    
    /**
     Build a new UPDATE URLRequest with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    static func buildUpdate<T : RestCall>(_ call : T) throws -> URLRequest{
        switch call.contentType {
            
        case .json:
            return try buildJsonPostUpdateRequest(call)
            
        case .multipart:
            return try buildJsonPostUpdateRequest(call)
            
        case .urlencoded:
            return try buildUrlEcodedPostUpdateRequest(call)
            
        }
        
    }
    
    /**
     Build a new DELETE URLRequest with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    static func buildDelete<T : RestCall>(_ call : T) -> URLRequest{
        var request = URLRequest(url: call.url)
        request.httpMethod = call.httpMethod.rawValue //set http method as DELETE
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Accept")
        return request
    }
}

extension RequestBuilder {
    
    /**
     Build a new POST/UPDATE URLRequest with JSON contentType with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    fileprivate static func buildJsonPostUpdateRequest<T : RestCall>( _ call: T) throws -> URLRequest {
        var request = URLRequest(url: call.url)
        request.httpMethod = call.httpMethod.rawValue //set http method as POST/UPDATE
        
        request.httpBody = try JSONSerialization.data(withJSONObject: call.bodyParams ?? Data(), options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Accept")
        return request
    }
    
    /**
     Build a new POST/UPDATE URLRequest with UrlEncodedParams contentType with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    fileprivate static func buildUrlEcodedPostUpdateRequest<T : RestCall>( _ call: T) throws -> URLRequest {
        var request = URLRequest(url: call.url)
        request.httpMethod = call.httpMethod.rawValue //set http method as POST/UPDATE
        
        request.httpBody = try buildUrlencodedData(call.bodyParams) // pass dictionary to nsdata object and set it as request body
        
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Accept")
        return request
    }
    
    /**
     Build a new POST/UPDATE URLRequest with MultiPartFormData contentType with the provided specifications from RestCall<T>.
     
     - Parameters:
     - call: The RestCall to be built
     
     - Returns: A URLRequest that matches the RestCall info configurations
     
     */
    fileprivate static func buildMultiPartFormDataPostUpdateRequest<T : RestCall>( _ call: T) throws -> URLRequest {
        var request = URLRequest(url: call.url)
        
        //set http method as POST/UPDATE
        request.httpMethod = call.httpMethod.rawValue
        
        // pass dictionary to nsdata object and set it as request body
        
        request.httpBody = try buildMultiPartFormData(call.bodyParams, call.mimeTypeData)
        
        request.addValue(call.contentType.rawValue + "; boundary=\(RestCall_RequestBuilderBoundary)", forHTTPHeaderField: "Content-Type")
        request.addValue(call.contentType.rawValue, forHTTPHeaderField: "Accept")
        return request
    }
    
}

extension RequestBuilder {
    
    /**
     Build a new POST/UPDATE URLRequest Body with MultiPartFormData contentType with the provided specifications from RestCall<T>.
     
     - Parameters:
     - params: [String:Any]?
     - mimes: [MimeType]?
     - Returns: A Data that matches the RestCall info configurations
     
     */
    fileprivate static func buildMultiPartFormData(_ params:[String:Any]?,_ mimes : [MimeType]?) throws -> Data {
        
        var body = NSMutableData()
        
        let boundaryPrefix = "--\(RestCall_RequestBuilderBoundary)\r\n"
        
        if nil != params {
            
            for (key, value) in params! {
                
                appendString(&body,boundaryPrefix)
                appendString(&body,"Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                appendString(&body,"\(value)\r\n")
                
            }
            
        }
        if nil !=  mimes {
            
            for mime in mimes! {
                
                appendString(&body,boundaryPrefix)
                appendString(&body,"Content-Disposition: form-data; name=\"file\"; filename=\"\(mime.filename)\"\r\n")
                appendString(&body,"Content-Type: \(mime.mimeType)\r\n\r\n")
                body.append(mime.data)
                appendString(&body,"\r\n")
                
            }
            
        }
        
        appendString(&body,"--".appending(RestCall_RequestBuilderBoundary.appending("--")))
        
        return body as Data
        
    }
    
    /**
     Helper method to build the url encoded cotent data
     
     - Parameters:
     - param: [String:Any]?
     
     */
    fileprivate static func buildUrlencodedData(_ param:[String:Any]?) throws -> Data {
        guard let params = param else{
            return Data()
        }
        
        let encodedString = params.map { (key, value) in
            return key + "=\(value)"
            }.map{ String($0) }.joined(separator: "&")
        
        guard let encodedData = encodedString.data(using: .utf8) else {
            throw (GenericError.dataNotFound)
        }
        return encodedData
        
    }
    
    /**
     To Avoid using extension (dependancy issue) append String to NSMutableData using inout params
     
     - Parameters:
     - data: inout NSMutableData
     - string: String
     
     */
    fileprivate static func appendString(_ data: inout NSMutableData,_ string: String) {
        let stringData = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        data.append(stringData!)
    }
}
