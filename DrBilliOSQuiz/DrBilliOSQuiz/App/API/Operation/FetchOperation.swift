//
//  FetchOperation.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/17/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import UIKit

class FetchOperation: NSOperation {
    private var _executing: Bool = false
    private var _finished: Bool = false
    
    var request: RequestType!
    var items: [QuizItem] = []
    
    override var executing: Bool {
        get { return _executing }
        set { _executing = newValue }
    }
    
    override var finished: Bool {
        get { return _finished }
        set { _finished = newValue }
    }
    
    
    override init() {}
    
    func setRequest(r: RequestType) {
        self.changeValue("isExecuting", bool: false)
        self.changeValue("isFinished", bool: false)
        self.request = r
    }
    
    override func start() {
        API.sendRequest(request) { (json) in
            dispatch_async(dispatch_get_main_queue(), {
                switch self.request.itemType {
                    case .Music: self.items = MusicItem.generateItems(json)
                    case .Book: self.items = BookItem.generateItems(json)
                }
                self.changeValue("isExecuting", bool: false)
                self.changeValue("isFinished", bool: true)
            })
        }
    }
    
    func changeValue(key: String, bool: Bool) {
        self.willChangeValueForKey(key)
        executing = (key == "isExecuting") ? bool : executing
        finished = (key == "isFinished") ? bool : finished
        self.didChangeValueForKey(key)
    }
    
}

