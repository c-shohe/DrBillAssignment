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
    
    static func getMusicRequest(key: String, callback: (JSON) -> Void) {
        API.sharedInstance.manager.request(.GET, "https://itunes.apple.com/search?term=\(key)&media=music&entity=song&country=us&lang=en_us&limit=10", parameters: nil).responseJSON { (response) in
            if let object = response.result.value {
                callback(JSON(object))
            }
        }
    }
    
    static func getBookRequest(key: String, callback: (JSON) -> Void) {
        API.sharedInstance.manager.request(.GET, "https://www.googleapis.com/books/v1/volumes?q=\(key)&country=US", parameters: nil).responseJSON { (response) in
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
