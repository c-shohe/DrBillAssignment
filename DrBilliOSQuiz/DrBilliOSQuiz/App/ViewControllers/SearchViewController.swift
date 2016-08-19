//
//  SearchViewController.swift
//  DrBilliOSQuiz
//
//  Created by SHOHE on 8/13/16.
//  Copyright © 2016 OhtaniShohe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var _tableView: UITableView!
    @IBOutlet weak var _searchBar: UISearchBar!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    private let logic: SearchViewLogic = SearchViewLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        logic.view = self
        logic.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardHandle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        removeKeyboardHandle()
    }
    
}


// MARK: - keyboard handling method.
extension SearchViewController {
    
    func addKeyboardHandle() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardWillShowNotification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardWillHideNotification(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardHandle() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        tableViewBottomConstraint.constant = keyboardScreenEndFrame.size.height
        commitLayoutAnimation()
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        tableViewBottomConstraint.constant = 0
        commitLayoutAnimation()
    }
    
    func commitLayoutAnimation() {
        view.setNeedsUpdateConstraints()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
}


// MARK: - SearchView
extension SearchViewController: SearchView {
    
    var tableView: UITableView? {
        return _tableView
    }
    
    var searchBar: UISearchBar? {
        return _searchBar
    }
    
}
