//
//  Response.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/14/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Response {
    
    var Url: NSURL { get }
    
    static func decode(j: JSON) -> Response?
    
}