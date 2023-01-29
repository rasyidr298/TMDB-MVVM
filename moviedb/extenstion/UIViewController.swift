//
//  UIViewController.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation
import Lottie

extension UIViewController {
  func showLottie(name: String, view: UIView, loop: LottieLoopMode, speed: CGFloat) {
    let animation = LottieAnimationView(name: name)
    animation.frame = view.bounds
    animation.contentMode = .center
    animation.loopMode = loop
    animation.animationSpeed = speed
    view.addSubview(animation)
    animation.play()
  }
  
  func showDoubleAlert(title: String, message: String, leftButton: String, rightButton: String, cancel: @escaping () -> Void, save: @escaping () -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: leftButton, style: UIAlertAction.Style.destructive, handler: {action in
      cancel()
    }))
    alert.addAction(UIAlertAction(title: rightButton, style: UIAlertAction.Style.default, handler: {action in
      save()
    }))
    self.present(alert, animated: true)
  }
  
  func showSingleAlert(title: String, message: String, button: String, completion: @escaping () -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: {action in
      completion()
    }))
    self.present(alert, animated: true)
  }
  
  func showGeneralError(message: String) {
    DispatchQueue.main.async {
      self.showSingleAlert(title: "Error", message: message, button: "Ok") { }
    }
  }
}
