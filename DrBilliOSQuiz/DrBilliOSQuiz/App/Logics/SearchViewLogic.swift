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
    private var fetchMusicOperation: NSBlockOperation!
    private var fetchBookOperation: NSBlockOperation!
    private var items: [[QuizItem]] = []
    
    weak var view: SearchView? = nil
    
    private let operationKey = "operationCount"
    
    func viewDidLoad() {
        setupView()
        setObserver()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == operationKey {
            let count = change!["new"] as! Int
            if count == 0 {
                reload()
            }
        }
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
        let item = items[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.title
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
        queue.maxConcurrentOperationCount = 1
        queue.addObserver(self, forKeyPath: operationKey, options: .New, context: nil)
    }

    private func fetch(key: String) {
        fetchMusicOperation = NSBlockOperation() {
            API.getMusicRequest(key) { (jsonObject) in
                print("1")
            }
        }
        fetchBookOperation = NSBlockOperation() {
            API.getBookRequest(key) { (jsonObject) in
                print("2")
            }
        }
        
        fetchBookOperation.addDependency(fetchMusicOperation)
        
        queue.addOperation(fetchMusicOperation)
        queue.addOperation(fetchBookOperation)
    }
    
    private func cancelFetch() {
        API.cancel()
        queue.cancelAllOperations()
        items.removeAll()
    }
    
    private func reload() {
        dispatch_async(dispatch_get_main_queue(), {
            self.view?.tableView?.reloadData()
        })
    }
    
}

