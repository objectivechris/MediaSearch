//
//  SearchViewController.swift
//  Media Search
//
//  Created by Christopher Rene on 3/26/17.
//  Copyright © 2017 Christopher Rene. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    struct TableViewCellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults: [SearchResult] = []
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 80
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        
        searchBar.becomeFirstResponder()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        searchResults = []
        
        if searchBar.text! != "Justin" {
            for i in 0...2 {
                let searchResult = SearchResult()
                searchResult.name = String(format: "Fake results %d for", i)
                searchResult.artistName = searchBar.text!
                searchResults.append(searchResult)
            }
        }
        
        hasSearched = true
        tableView.reloadData()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            cell.artistNameLabel.text = searchResult.artistName
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}

