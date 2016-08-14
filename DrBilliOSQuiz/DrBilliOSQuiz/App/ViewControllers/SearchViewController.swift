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
    
    private let logic: SearchViewLogic = SearchViewLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        logic.view = self
        logic.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
