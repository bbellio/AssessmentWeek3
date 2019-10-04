//
//  SearchResultsListTableViewController.swift
//  MovieSearch
//
//  Created by Bethany Wride on 10/4/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class SearchResultsListTableViewController: UITableViewController {
    // MARK: - Variables
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.estimatedRowHeight = 225
        self.tableView.rowHeight = 225
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.movie = movies[indexPath.row]
        return cell
    }
} // End of class

// MARK: - Extension
extension SearchResultsListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchResultController.searchMovieDatabaseWith(searchText: searchText) { (movies) in
            self.movies = movies
        }
    }
}

