//
//  MusicRequest.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/18/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import Foundation
import Alamofire

class MusicRequest: RequestType {
    
    private let term: String
    private let media: String
    private let entity: String
    private let country: String
    private let lang: String
    private let limit: Int
    
    init(term: String, media: String, entity: String, country: String, lang: String, limit: Int) {
        self.term = term
        self.media = media
        self.entity = entity
        self.country = country
        self.lang = lang
        self.limit = limit
    }
    
    var method: Alamofire.Method {
        return .GET
    }
    
    var itemType: ItemType {
        return .Music
    }
    
    var path: String {
        return "search"
    }

    var parameters: [String : AnyObject]? {
        return ["term": term,
                "media": media,
                "entity": entity,
                "country": country,
                "lang": lang,
                "limit": limit]
    }

}