//
//  DetailVM.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation
import RxCocoa
import RxSwift

class HomeVM {
  
  let popularMovies: BehaviorRelay<ViewState<[Movie]>> = .init(value: ViewState.Initiate())
  private let disposeBag = DisposeBag()
  
  func fetchPopularMovies(page: Int) {
    popularMovies.accept(ViewState.Loading())
    
    MovieServices.shared.fetchPopularMovie(page: page).subscribe(
      onNext: { [weak self] result in
        self?.popularMovies.accept(ViewState.Success(data: result))
      },
      onError: { [weak self] error in
        self?.popularMovies.accept(ViewState.Failed(error: error))
      }
    ).disposed(by: disposeBag)
  }
}
