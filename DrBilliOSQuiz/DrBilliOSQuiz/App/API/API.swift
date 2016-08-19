//
//  API.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/13/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import Foundation
import UIKit

import Alamofire
import SwiftyJSON


final class API {
    static let sharedInstance: API = API()
    private var configuration: NSURLSessionConfiguration!
    private var manager: Alamofire.Manager!
    private var request: Alamofire.Request?
    
    private init() {
        configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        manager = Alamofire.Manager(configuration: configuration)
    }
    
    static func sendRequest(r: RequestType, callback: (JSON) -> Void) {
        API.sharedInstance.manager.request(r.method, r.buildRequestURL().absoluteString).responseJSON { (response) in
            if let object = response.result.value {
                callback(JSON(object))
            }
        }
    }
    
    static func resume() {
        API.sharedInstance.request?.resume()
    }
    
    static func suspend() {
        API.sharedInstance.request?.suspend()
    }
    
    static func cancel() {
        API.sharedInstance.request?.cancel()
    }

}


// MARK: - private method.
extension API {
    
    private func buildRequestURL(requestType: RequestType) -> NSURL {
        return NSURL()
    }
    
}
