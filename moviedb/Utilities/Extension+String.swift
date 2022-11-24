//
//  ExtentionString.swift
//  moviedb
//
//  Created by Rasyid Ridla on 24/11/22.
//

import Foundation

extension String {
  
  func rating(vote: Double) -> String {
    let rating = Int(vote)
    let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
      return acc + "⭐️"
    }
    return ratingText
  }
}
