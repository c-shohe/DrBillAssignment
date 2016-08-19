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
    private var fetchMusicOperation, fetchBookOperation: FetchOperation!
    private var completedOperation: NSBlockOperation!
    private var items: [[QuizItem]] = []
    
    weak var view: SearchView? = nil
    
    func viewDidLoad() {
        setupView()
        setQueue()
    }
    
    deinit {}
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        let item = items[indexPath.section][indexPath.row]
        cell!.textLabel?.text = item.title
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Music" : (section == 1) ? "Book" : ""
    }
    
}


// MARK: - UISearchBarDelegate
extension SearchViewLogic: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        cancelFetch()
        fetch(searchText)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
    
    private func setQueue() {
        queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
    }

    private func fetch(key: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        prepareRequest(key)
        
        fetchBookOperation.addDependency(fetchMusicOperation)
        completedOperation.addDependency(fetchBookOperation)
        queue.addOperation(fetchMusicOperation)
        queue.addOperation(fetchBookOperation)
        queue.addOperation(completedOperation)
    }
    
    private func prepareRequest(key: String) {
        fetchMusicOperation = FetchOperation()
        fetchBookOperation = FetchOperation()
        
        let musicRequest = MusicRequest(term: key, media: "music", entity: "song", country: "us", lang: "en_us", limit: 10)
        fetchMusicOperation.setRequest(musicRequest)
        
        let bookRequest = BookRequest(q: key, country: "US")
        fetchBookOperation.setRequest(bookRequest)
        
        initCompletedOperation()
    }
    
    private func initCompletedOperation() {
        completedOperation = NSBlockOperation {
            self.items.append(self.fetchMusicOperation.items)
            self.items.append(self.fetchBookOperation.items)
            self.reload()
        }
    }
    
    private func cancelFetch() {
        API.cancel()
        queue.cancelAllOperations()
        items.removeAll()
    }
    
    private func reload() {
        dispatch_async(dispatch_get_main_queue(), {
            self.view?.tableView?.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
}


