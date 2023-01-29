//
//  DetailVM.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation
import RxCocoa
import RxSwift

class DetailVM {
  
  let videosMovie: BehaviorRelay<ViewState<[MovieVideo]>> = .init(value: ViewState.Initiate())
  let reviewsMovie: BehaviorRelay<ViewState<[MovieReview]>> = .init(value: ViewState.Initiate())
  private let disposeBag = DisposeBag()
  
  func fetchVideosMovie(idMovie: Int) {
    videosMovie.accept(ViewState.Loading())
    
    MovieServices.shared.fetchVideo(idMovie: idMovie).subscribe(
      onNext: { [weak self] result in
        self?.videosMovie.accept(ViewState.Success(data: result))
      },
      onError: { [weak self] error in
        self?.videosMovie.accept(ViewState.Failed(error: error))
      }
    ).disposed(by: disposeBag)
  }
  
  func fetchReviewsMovie(idMovie: Int, page: Int) {
    reviewsMovie.accept(ViewState.Loading())
    
    MovieServices.shared.fetchReviews(idMovie: idMovie, page: page).subscribe(
      onNext: { [weak self] result in
        self?.reviewsMovie.accept(ViewState.Success(data: result))
      },
      onError: { [weak self] error in
        self?.reviewsMovie.accept(ViewState.Failed(error: error))
      }
    ).disposed(by: disposeBag)
  }
}

