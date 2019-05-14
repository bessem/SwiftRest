//
//  RestCall.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import Foundation

/**
 
 protocol RestCall serve as a base Http https calls
 /// Better call saul
 
 */
protocol RestCall {
    
    ///responseBodyType `T` must be `Codable` , it will be used when parsing and creating web service response from json
    associatedtype T: Codable
    
    ///callInterceptor `RestCallInterceptor` used to intercept the url request
    var callInterceptor : RestCallInterceptor { get }
    
    /// The call `method`, le swift : -"all, what are u ?"
    var httpMethod :  HttpMethod { get }
    
    /** The `callRoot`
     -  scheme
     -  baseUrl
     -  endPoint
     -  query
     */
    var callRoot: CallRoot { get }
    
    /** The `contentType` depends on api definition :
     -   url encoded
     -   Json
     -   ....allowed ContentType
     */
    var contentType: ContentType { get }
    
    /**  The `bodyParam`
     -   json
     -   urlencoded
     -   formdata
     -   multipart
     */
    var bodyParams : [String : Any]? { get set }
    
    /**  The `additionalData` it can be images, files, ... some data
     -   formdata
     -   multipart
     */
    var mimeTypeData : [MimeType]? { get set }
    
    
}

// check data Phase
extension RestCall {
    
    /**  The **RestCallInterceptor** `callInterceptor`
     
     it serve as call interceptor, can be used to add generic auth params to the request headers, request if needed
     
     */
    var callInterceptor : RestCallInterceptor {
        get{
            return RestCallInterceptor()
        }
    }
    
    /**  The flag `isMalformed`
     
     The result of building url components
     
     le swift : -"URL, are you okay ?"
     
     */
    var isMalformed : Bool {
        get{
            var components = URLComponents()
            components.scheme = callRoot.scheme
            components.host = callRoot.host
            components.path = callRoot.path
            components.queryItems = callRoot.queryItems
            guard let _ = components.url else {
                return true
            }
            return false
        }
    }
    /**  The `url`
     
     The result of building url components
     
     */
    var url : URL {
        get{
            var components = URLComponents()
            components.scheme = callRoot.scheme
            components.host = callRoot.host
            components.path = callRoot.path
            components.queryItems = callRoot.queryItems
            return components.url!
        }
    }
}

/// Execution Phase
extension RestCall {
    
    /**
     This method execute and return the task back, developper can use the task ref to cancel it, pause it, resume it back...
     
     - Remark: The result back to the user on main thread
     - Parameter session: **URLSession** the connection that will create the task that will be performed
     - Parameter completion: **Result** The result of the execution an enum <success, fail>.
     - Returns: The URLSessionDataTask to be executed
     */
    @discardableResult /// supress warning in unused result ...
    func execute(_ session :URLSession, completion: @escaping (Result<T,GenericError>) -> Void) -> URLSessionDataTask? {
        
        /// it all about the url !
        /// the map that will guide data through it's journey
        if isMalformed {
            DispatchQueue.main.async {
                completion(Result.failure(GenericError.malformedUrl))
            }
            return nil
        }
        
        /// build the request with suitable params
        do {
            var request = try RequestBuilder.build(self)
            
            
            /// in case the call require interception of the header for additional config u can use a CallInterceptor
            self.callInterceptor.intercept(&request)
            
            /// create dataTask using a session object (might be custom)
            /// prepare the mission
            /// dear data, ride this task and go to the back end, ask him for data exchange, u can do it. blessed, see u soon.
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                guard error == nil else {
                    /// just to distinguish between a canceled call (i.e: pagination + pull refresh scenario)
                    if (error as NSError?)?.code == NSURLErrorCancelled {
                        DispatchQueue.main.async {
                            completion(Result.failure(GenericError.canceled))
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion(Result.failure(GenericError.networkError(error!)))
                        }
                    }
                    return
                }
                
                /// sometimes it's an error
                /// sometimes it's just a developper logic
                /// who know's ?!
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(Result.failure(GenericError.dataNotFound))
                    }
                    return
                }
                
                do {
                    /// Decodable, we love u.
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(Result.success(decodedObject))
                    }
                } catch let error {
                    /// $#!* happens
                    DispatchQueue.main.async {
                        completion(Result.failure(GenericError.jsonParsingError(error as! DecodingError)))
                    }
                }
            })
            
            /// maybe u need (task ref) in some cases
            /// Open the pipe & Start The mission
            /// see u soon request
            /// u can do it ;)
            task.resume()
            
            return task
        }
        catch (let error as GenericError){
            completion(Result.failure(error))
            return nil
        }
        catch{
            completion(Result.failure(GenericError.badData))
            return nil
        }
    }
    
    /**
     This method mock Rest Call from json files
     
     - Remark: The result back to the user on main thread
     - Parameter fileName: **String** the file that contains mock data
     - Parameter completion: **Result** The result of the execution an enum <success, fail>.
     */
    func mock(_ fileName : String, completion: @escaping (Result<T,GenericError>) -> Void){
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    /// Decodable, we love u.
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(Result.success(decodedObject))
                    }
                } catch let error {
                    /// $#!* happens
                    DispatchQueue.main.async {
                        completion(Result.failure(GenericError.jsonParsingError(error as! DecodingError)))
                    }
                }
            } catch {
                /// File content Cant be seen as Data
                DispatchQueue.main.async {
                    completion(Result.failure(GenericError.badData))
                }
            }
        }else {
            /// File Not Found
            DispatchQueue.main.async {
                completion(Result.failure(GenericError.dataNotFound))
            }
        }
    }
    
}
