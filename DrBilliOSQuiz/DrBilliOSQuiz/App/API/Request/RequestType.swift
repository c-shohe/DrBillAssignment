//
//  RequestType.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/18/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestType {
    var itemType: ItemType { get }
    var method: Alamofire.Method { get }
    var path: String { get }
    var parameters: [String: AnyObject]? { get }
}

extension RequestType {
    
    func buildRequestURL() -> NSURL {
        var base = requestURL().absoluteString
        base += "?"
        parameters?.forEach({ (param, value) in
            base += "\(param)=\(value)&"
        })
        let url = NSMutableString(string: base)
        url.deleteCharactersInRange(NSRange(location: url.length-1, length: 1))
        return NSURL(string: url as String)!
    }
    
    func requestURL() -> NSURL{
        return path.isEmpty ? itemType.baseURL : itemType.baseURL.URLByAppendingPathComponent(path)
    }
    
}