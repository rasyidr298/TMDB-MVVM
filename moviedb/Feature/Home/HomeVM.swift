//
//  DetailVM.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation
import RxCocoa

class HomeVM {
  
  private let movieService: MovieService
  
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
  
  var numberOfMovies: Int {
    return _movies.value.count
  }
  
  var error: Driver<String?> {
    return _error.asDriver()
  }
  
  var hasError: Bool {
    return _error.value != nil
  }
  
  func fetchMovies(page: Int) {
    self._movies.accept([])
    self._isFetching.accept(true)
    self._error.accept(nil)
    
    movieService.fetchMovies(page: page) {[weak self] result in
      guard let self = self else {return}
      
      switch result {
      case .success(let movies):
        self._isFetching.accept(false)
        self._movies.accept(movies.results)
      case .failure(let error):
        self._isFetching.accept(false)
        self._error.accept(error.localizedDescription)
      }
    }
  }
  
}
