//
//  MovieCell.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var imgPoster: UIImageView!
  
  func configure(movie: Movie) {
    lblTitle.text = movie.title
    imgPoster.kf.setImage(with: movie.posterURL)
  }
}
