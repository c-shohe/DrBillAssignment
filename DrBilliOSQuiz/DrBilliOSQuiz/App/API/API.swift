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
    
    private init() {
        
    }
    
    static func getMusicRequest(key: String, callback: (JSON?) -> Void) {
        Alamofire.request(.GET, "https://itunes.apple.com/search?term=\(key)&media=music&entity=song&country=us&lang=en_us&limit=10").responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            callback(JSON(object))
        }
    }
    
    static func getBookRequest(key: String, callback: (JSON?) -> Void) {
        Alamofire.request(.GET, "https://www.googleapis.com/books/v1/volumes?q=\(key)&country=US").responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            callback(JSON(object))
        }
    }
    
}
