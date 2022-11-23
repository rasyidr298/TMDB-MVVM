//
//  DetailVM.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeVM {
  
  private let movieService: MovieService
  private let disposeBag = DisposeBag()
  
  init(movieService: MovieService) {
    self.movieService = movieService
  }
  
  private let _movies = BehaviorRelay<[Movie]>(value: [])
  private let _isFetching = BehaviorRelay<Bool>(value: false)
  private let _error = BehaviorRelay<String?>(value: nil)
  
  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }
  
  var movies: Driver<[Movie]> {
    return _movies.asDriver()
  }
  
  var error: Driver<String?> {
    return _error.asDriver()
  }
  
  func fetchMovies(page: Int) {
    self._movies.accept([])
    self._isFetching.accept(true)
    self._error.accept(nil)
    
    movieService.fetchMovies(page: page, successHandler: {[weak self] (response) in
      self?._isFetching.accept(false)
      self?._movies.accept(response.results)
      
    }) { [weak self] (error) in
      self?._isFetching.accept(false)
      self?._error.accept(error.localizedDescription)
    }
  }
  
}
