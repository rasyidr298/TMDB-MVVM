//
//  UIFont.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import UIKit

enum FontType {
  case sfBold
  case sfHeavy
  case sfMedium
  case sfRegular
  case sfSemibold
}

extension UIFont {
  class func font(type: FontType, size: CGFloat) -> UIFont {
    switch type {
    case .sfBold:
      return UIFont(name: "SFCompactText-Bold", size: size) ?? .systemFont(ofSize: size)
    case .sfHeavy:
      return UIFont(name: "SFCompactText-Heavy", size: size) ?? .systemFont(ofSize: size)
    case .sfMedium:
      return UIFont(name: "SFCompactText-Medium", size: size) ?? .systemFont(ofSize: size)
    case .sfRegular:
      return UIFont(name: "SFCompactText-Regular", size: size) ?? .systemFont(ofSize: size)
    case .sfSemibold:
      return UIFont(name: "SFCompactText-Semibold", size: size) ?? .systemFont(ofSize: size)
    }
  }
}

extension UIFont {
  class func printFontNames() {
    for family in UIFont.familyNames {
      let fonts = UIFont.fontNames(forFamilyName: family)
      
      print("Family: ", family, "Font Names: ", fonts)
    }
  }
}
