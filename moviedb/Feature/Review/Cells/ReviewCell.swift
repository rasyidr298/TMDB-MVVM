//
//  ReviewCell.swift
//  moviedb
//
//  Created by Rasyid Ridla on 24/11/22.
//

import UIKit

class ReviewCell: UITableViewCell {
  
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblContent: UILabel!
  
  func configure(review: MovieReview) {
    lblName.text = review.author
    lblContent.text = review.content
  }
}
