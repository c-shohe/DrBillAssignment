//
//  QuizItem.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/16/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import Foundation

enum ItemType {
    case Music, Book
    
    var baseURL: NSURL {
        switch self {
        case .Music:
            return NSURL(string: "https://itunes.apple.com")!
        case .Book:
            return NSURL(string: "https://www.googleapis.com")!
        }
    }
}

class QuizItem: NSObject {
    
    var itemType: ItemType?
    var title: String = ""
    
}
