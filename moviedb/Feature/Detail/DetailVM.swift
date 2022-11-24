//
//  DetailVM.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation
import RxCocoa

class DetailVM {
  
  private let movieService: MovieService
  
  init(movieService: MovieService) {
    self.movieService = movieService
  }
  
  private let _video = BehaviorRelay<[MovieVideo]>(value: [])
  private let _isFetching = BehaviorRelay<Bool>(value: false)
  private let _error = BehaviorRelay<String?>(value: nil)
  
  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }
  
  var video: Driver<[MovieVideo]> {
    return _video.asDriver()
  }
  
  var error: Driver<String?> {
    return _error.asDriver()
  }
  
  func fetchVideo(idMovie: Int) {
    self._video.accept([])
    self._isFetching.accept(true)
    self._error.accept(nil)
    
    movieService.fetchMovieVideo(idMovie: idMovie) {[weak self] result in
      guard let self = self else {return}
      
      switch result {
      case .success(let movies):
        self._isFetching.accept(false)
        self._video.accept(movies.results)
      case .failure(let error):
        self._isFetching.accept(false)
        self._error.accept(error.localizedDescription)
      }
    }
  }
}

