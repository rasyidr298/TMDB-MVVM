//
//  ReviewVM.swift
//  moviedb
//
//  Created by Rasyid Ridla on 24/11/22.
//

import Foundation
import RxCocoa

class ReviewVM {
  
  private let movieService: MovieService
  
  init(movieService: MovieService) {
    self.movieService = movieService
  }
  
  private let _review = BehaviorRelay<[MovieReview]>(value: [])
  private let _isFetching = BehaviorRelay<Bool>(value: false)
  private let _error = BehaviorRelay<String?>(value: nil)
  
  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }
  
  var reviews: Driver<[MovieReview]> {
    return _review.asDriver()
  }
  
  var numberOfReview: Int {
    return _review.value.count
  }
  
  var error: Driver<String?> {
    return _error.asDriver()
  }
  
  var hasError: Bool {
    return _error.value != nil
  }
  
  var isEmpty: Bool {
    return _review.value.isEmpty
  }
  
  func fetchReview(idMovie: Int) {
    self._review.accept([])
    self._isFetching.accept(true)
    self._error.accept(nil)
    
    movieService.fetchMovieReview(idMovie: idMovie) {[weak self] result in
      guard let self = self else {return}
      
      switch result {
      case .success(let reviews):
        self._isFetching.accept(false)
        self._review.accept(reviews.results)
      case .failure(let error):
        self._isFetching.accept(false)
        self._error.accept(error.localizedDescription)
      }
    }
  }
}
