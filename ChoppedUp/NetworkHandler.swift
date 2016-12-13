//
//  NetworkHandler.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-09.
//  Copyright © 2016 FEO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias APIParams = [String : Any]?

protocol APIConfiguration {
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseURL: URL { get }
}

enum EndPoint {
    case getTasks
}



class Router: URLRequestConvertible, APIConfiguration {


    internal var encoding: ParameterEncoding?

    var endPoint: EndPoint
    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }
    
    
    var baseURL: URL {
        return URL(fileURLWithPath: "https://chopped-up.feomedia.se/")
    }


    var method: Alamofire.HTTPMethod {
        switch endPoint {
        case .getTasks:       return .get
        }
    }
    
    var path: String {
        switch endPoint {
        case .getTasks:      return "qa/"
        }
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: self.baseURL.appendingPathComponent(path))
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.httpMethod = method.rawValue
        
        let request = try URLEncoding.default.encode(urlRequest, with: parameters)
        return request
    }
    
    var parameters: APIParams {
        switch endPoint {
        case .getTasks:
            return [:]
        }
    }

}



class NetworkHandler {
    
    static var sharedInstance = NetworkHandler()
    
    
    func getTasks(completion: @escaping (_ tasks: [String : String]?,_ errorJson: JSON?) -> ()) -> Request {

        let router = Router(endPoint: .getTasks)
        
        return request(router)
            .validate()
            .responseJSON { response in
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    var tasks: [String : String] = [:]
                  
                    tasks = (json["data"].dictionaryObject as? [String : String])!
                    completion(tasks, nil)
                    } else {
                        completion(nil, nil)
                    }
                }
        }
    }
