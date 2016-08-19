//
//  MusicItem.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/16/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import UIKit
import SwiftyJSON

class MusicItem: QuizItem {
    
    var artistName: String?
    
    static func generateItems(object: JSON) -> [MusicItem] {
        var items: [MusicItem] = []
        for obj in object["results"] {
            let item = MusicItem()
            item.artistName = obj.1["artistName"].string
            item.title = obj.1["trackName"].string!
            items.append(item)
        }
        return items
    }
    
}

