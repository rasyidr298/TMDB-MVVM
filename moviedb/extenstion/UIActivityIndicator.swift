//
//  UIActivityIndicator.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
  func stop() {
    self.stopAnimating()
    self.hidesWhenStopped = true
  }
  
  func start() {
    self.startAnimating()
  }
}
