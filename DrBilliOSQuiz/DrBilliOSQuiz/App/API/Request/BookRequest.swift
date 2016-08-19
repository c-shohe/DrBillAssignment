//
//  BookRequest.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/18/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import Foundation
import Alamofire

class BookRequest: RequestType {
    
    private let q: String
    private let country: String
    
    init(q: String, country: String) {
        self.q = q
        self.country = country
    }
    
    var itemType: ItemType {
        return .Book
    }
    
    var method: Alamofire.Method {
        return .GET
    }
    
    var path: String {
        return "books/v1/volumes"
    }
    
    var parameters: [String : AnyObject]? {
        return ["q": q, "country": country]
    }
    
}