//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Michael Duong on 2/2/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Search"
        searchBar.delegate = self
    }
    
    var movie: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MoviesController.shared.results.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? ThumbnailTableViewCell else { return UITableViewCell() }
        let movie = MoviesController.shared.results[indexPath.row]

        cell.updateViews(movie: movie)
        
        return cell
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let input = searchBar.text, input != "" else
        { return }
        searchBar.resignFirstResponder()
        let cleanedInput = input.replacingOccurrences(of: " ", with: "+")
        MoviesController.shared.fetchMovies(searchTerm: cleanedInput) { (newMovie) in
            DispatchQueue.main.async {
                self.movie = newMovie
            }
        }
    }
}
