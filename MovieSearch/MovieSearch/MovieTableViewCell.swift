//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Bethany Wride on 10/4/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    // MARK: - Variables
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            SearchResultController.getMoviePosterFor(movie: movie) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.updateViews(movie: movie, image: image)
                    }
                }
            }
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    func updateViews(movie: Movie, image: UIImage) {
        DispatchQueue.main.async {
            self.movieTitleLabel.text = movie.title
            self.movieRatingLabel.text = "\(movie.vote_average)"
            self.movieOverviewLabel.text = movie.overview
            self.posterImage.image = nil
            self.posterImage.image = image
        }
    }
}
