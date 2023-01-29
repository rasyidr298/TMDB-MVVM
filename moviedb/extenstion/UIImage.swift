//
//  UIImahge.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation
import Kingfisher

public extension UIImageView {
  func setImageUrl(urlPath: String){
    if let url = URL(string: urlPath) {
      self.kf.indicatorType = .activity
      self.kf.setImage(
        with: url
      )
    }
  }
}
