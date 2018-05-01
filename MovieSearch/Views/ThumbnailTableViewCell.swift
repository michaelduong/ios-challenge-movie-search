//
//  ThumbnailTableViewCell.swift
//  MovieSearch
//
//  Created by Michael Duong on 2/2/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import UIKit

class ThumbnailTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieThumbnail: UIImageView!
    

    func updateViews(movie: Movie) {
        
        DispatchQueue.main.async {
            self.movieTitleLabel.text = movie.title
            self.movieSummaryLabel.text = movie.overview
            self.movieRatingLabel.text = "Rating: \(movie.vote_average ?? 0)"
            
            guard let posterPath = movie.poster_path else { return }
            
            MoviesController.shared.fetchThumbnail(posterPath: posterPath, completion: { (posterImage) in
                if let poster = posterImage {
                    DispatchQueue.main.async {
                        self.movieThumbnail.image = poster
                    }
                } else {
                    DispatchQueue.main.async {
                        self.movieThumbnail.image = #imageLiteral(resourceName: "emptyMovie")
                    }
                }
            })
        }
    }
}
