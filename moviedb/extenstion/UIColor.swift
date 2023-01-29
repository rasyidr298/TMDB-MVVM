//
//  UIColor.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation
import UIKit

extension UIColor {
  static var random: UIColor {
    let red:CGFloat = CGFloat(drand48())
    let green:CGFloat = CGFloat(drand48())
    let blue:CGFloat = CGFloat(drand48())
    
    return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
  }
}

extension UIColor {
  static let primaryBlack = UIColor(red: 51, green: 51, blue: 51, alpha: 1)
  static let white = UIColor(hexString: "#FFFFFF")
  static let blue = UIColor(hexString: "#233862")
  static let navigationBarTintColor = baseLightest
  static let baseLightest = UIColor(hexString: "#F7F9FA")
  static let blackDarkest = UIColor(hexString: "#090A0A")
  static let blueBase = UIColor(hexString: "#1F2B5B")
  static let blackBase = UIColor(hexString: "#404446")
  static let greenBase = UIColor(hexString: "#00D8AA")
  static let greenDarkest = UIColor(hexString: "#00B48E")
  static let blackDark = UIColor(hexString: "#303437")
  static let blackLighter = UIColor(hexString: "#72777A")
  static let grayLight = UIColor(hexString: "#141414")
}

extension UIColor {
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
}
