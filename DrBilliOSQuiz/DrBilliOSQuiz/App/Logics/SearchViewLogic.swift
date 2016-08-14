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
    private let queue = NSOperationQueue()
    weak var view: SearchView? = nil
    
    func viewDidLoad() {
        setupView()
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
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "--"
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
    
    private func fetch(key: String) {
        let fetchMusicOperation = NSBlockOperation { API.getMusicRequest(key) }
        let fetchBookOperation = NSBlockOperation { API.getBookRequest(key) }
        
        fetchBookOperation.addDependency(fetchMusicOperation)
        
        queue.addOperation(fetchMusicOperation)
        queue.addOperation(fetchBookOperation)
    }
    
    private func cancelFetch() {
        queue.cancelAllOperations()
    }
    
}

