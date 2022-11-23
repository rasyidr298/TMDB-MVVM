//
//  DetailVM.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class DetailVM {
  
  private let movieService: MovieService
  private let disposeBag = DisposeBag()
  
  init(movieService: MovieService) {
    self.movieService = movieService
  }
  
  private let _review = BehaviorRelay<[MovieReview]>(value: [])
  private let _video = BehaviorRelay<[MovieVideo]>(value: [])
  private let _isFetching = BehaviorRelay<Bool>(value: false)
  private let _error = BehaviorRelay<String?>(value: nil)
  
  var isFetching: Driver<Bool> {
    return _isFetching.asDriver()
  }
  
  var reviews: Driver<[MovieReview]> {
    return _review.asDriver()
  }
  
  var video: Driver<[MovieVideo]> {
    return _video.asDriver()
  }
  
  var error: Driver<String?> {
    return _error.asDriver()
  }
  
  func fetchReview(idMovie: Int) {
    self._review.accept([])
    self._isFetching.accept(true)
    self._error.accept(nil)
    
    movieService.fetchMovieReview(idMovie: idMovie, successHandler: {[weak self] (response) in
      self?._isFetching.accept(false)
      self?._review.accept(response.results)
      
    }) { [weak self] (error) in
      self?._isFetching.accept(false)
      self?._error.accept(error.localizedDescription)
    }
  }
  
  func fetchVideo(idMovie: Int) {
    self._video.accept([])
    self._isFetching.accept(true)
    self._error.accept(nil)
    
    movieService.fetchMovieVideo(idMovie: idMovie, successHandler: {[weak self] (response) in
      self?._isFetching.accept(false)
      self?._video.accept(response.results)
      
    }) { [weak self] (error) in
      self?._isFetching.accept(false)
      self?._error.accept(error.localizedDescription)
    }
  }
  
}

