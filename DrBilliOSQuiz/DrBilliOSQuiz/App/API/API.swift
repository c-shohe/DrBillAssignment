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
    
    static func getMusicRequest(name: String) {
        Alamofire.request(.GET, "https://itunes.apple.com/search?term=\(name)&media=music&entity=song&country=us&lang=en_us&limit=10").responseJSON { response in
            print("response: \(response)")
        }
    }
    
}
