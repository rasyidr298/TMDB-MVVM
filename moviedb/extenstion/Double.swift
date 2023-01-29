//
//  ExtentionString.swift
//  moviedb
//
//  Created by Rasyid Ridla on 24/11/22.
//

import Foundation

extension Double {
  
  func rating() -> String {
    let rating = Int(self)
    let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
      return acc + "⭐️"
    }
    return ratingText
  }
}
