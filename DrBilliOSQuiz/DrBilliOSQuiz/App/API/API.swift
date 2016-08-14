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


final class API {
    static let sharedInstance: API = API()
    
    private init() {
        
    }
    
    static func getMusicRequest(key: String) {
        Alamofire.request(.GET, "https://itunes.apple.com/search?term=\(key)&media=music&entity=song&country=us&lang=en_us&limit=10").responseJSON { response in
            print("response: \(response)")
        }
    }
    
    static func getBookRequest(key: String) {
        Alamofire.request(.GET, "https://www.googleapis.com/books/v1/volumes?q=\(key)&country=US").responseJSON { response in
            print("response: \(response)")
        }
    }
    
}
