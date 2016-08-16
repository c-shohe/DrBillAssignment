//
//  SearchViewLogic.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/13/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import UIKit

protocol SearchView: class {
    var tableView: UITableView? { get }
    var searchBar: UISearchBar? { get }
}

class SearchViewLogic: NSObject {
    private var queue: NSOperationQueue!
    private let operationKey = "operationCount"
    
    private var items: [[String]] = []
    weak var view: SearchView? = nil
    
    func viewDidLoad() {
        setupView()
        setObserver()
    }
    
    deinit {
        queue.removeObserver(self, forKeyPath: operationKey)
    }
}


// MARK: - UITableViewDelegate
extension SearchViewLogic: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
    }
    
}


// MARK: - UITableViewDataSource
extension SearchViewLogic: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)section"
    }
    
}


// MARK: - UISearchBarDelegate
extension SearchViewLogic: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        cancelFetch()
        fetch(searchText)
    }
    
    
}


// MARK: - private methods
extension SearchViewLogic {
    
    private func setupView() {
        view?.tableView?.delegate = self
        view?.tableView?.dataSource = self
        view?.tableView?.scrollsToTop = true
        view?.searchBar?.delegate = self
    }
    
    private func setObserver() {
        queue = NSOperationQueue()
        queue.addObserver(self, forKeyPath: operationKey, options: .New, context: nil)
    }
    
    private func fetch(key: String) {
        let fetchMusicOperation = NSBlockOperation {
            API.getMusicRequest(key) { (jsonObject) in
                print(jsonObject)
            }
            
            // table test
            var musicItem: [String] = []
            for i in 0..<10 {
                musicItem.append("music\(i)")
            }
            self.items.removeAll()
            self.items.append(musicItem)
        }
        let fetchBookOperation = NSBlockOperation {
            API.getBookRequest(key) { (jsonObject) in
                print(jsonObject)
            }
            
            // table test
            var bookItem: [String] = []
            for i in 0..<10 {
                bookItem.append("book\(i)")
            }
            self.items.append(bookItem)
        }
        
        fetchBookOperation.addDependency(fetchMusicOperation)
        
        queue.addOperation(fetchBookOperation)
        queue.addOperation(fetchMusicOperation)
    }
    
    private func cancelFetch() {
        queue.cancelAllOperations()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == operationKey {
            let count = change!["new"] as! Int
            if count == 0 {
                dispatch_async(dispatch_get_main_queue(), { 
                    self.view?.tableView?.reloadData()
                })
            }
        }
    }
    
}

