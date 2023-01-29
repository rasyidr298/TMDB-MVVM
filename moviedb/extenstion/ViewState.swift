//
//  ViewState.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation

class ViewState<T> {
  public var value: T? {
    return (self as? Success<T>)?.data
  }
  
  public var error: Error? {
    return (self as? Failed)?.reason
  }
  
  public init() {}
  
  public class Initiate: ViewState {}
  
  public class Loading: ViewState {}
  
  public class Success<T>: ViewState {
    let data: T
    
    public init(data: T) {
      self.data = data
      super.init()
    }
  }
  
  public class Failed: ViewState {
    public let reason: Error
    
    public init(error: Error) {
      self.reason = error
      super.init()
    }
  }
}

public enum SimpleViewState<T> {
  case initiate
  case loading
  case error(error: Error)
  case success(data: T)
  
  var value: T? {
    if case .success(let data) = self {
      return data
    }
    return nil
  }
}

extension ViewState {
  func simplify() -> SimpleViewState<T> {
    switch self {
    case is ViewState<T>.Loading:
      return .loading
    case is ViewState<T>.Success<T>:
      return .success(data: self.value!)
    case let x where x is ViewState<T>.Failed:
      return .error(error: self.error!)
    default:
      return .initiate
    }
  }
}

