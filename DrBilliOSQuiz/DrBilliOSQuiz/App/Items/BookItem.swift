//
//  BookItem.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/18/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import UIKit
import SwiftyJSON

class BookItem: QuizItem {
    
    var authors: String?
    
    static func generateItems(object: JSON) -> [BookItem] {
        var items: [BookItem] = []
        for obj in object["items"] {
            let item = BookItem()
            item.authors = obj.1["volumeInfo"]["authors"].stringValue
            item.title = obj.1["volumeInfo"]["title"].stringValue
            items.append(item)
        }
        return items
    }
    
}