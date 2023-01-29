//
//  MovieStore.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation
import RxSwift
import Alamofire

protocol MovieServiceProtocol {
  func fetchPopularMovie(page: Int) -> Observable<[Movie]>
  func fetchReviews(idMovie: Int, page: Int) -> Observable<[MovieReview]>
  func fetchVideo(idMovie: Int) -> Observable<[MovieVideo]>
}

public class MovieServices: MovieServiceProtocol {
  
  public static let shared = MovieServices()
  
  func fetchPopularMovie(page: Int) -> Observable<[Movie]> {
    return Observable.create { observer in
      if let requestURL = URL(string: ApiCall.URL_MOVIES_POPULAR(page)) {
        AF.request(requestURL, method: .get)
          .validate()
          .responseDecodable(of: MovieResponse.self) {response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.movie ?? [Movie.default])
            case .failure(let error):
              observer.onError(error)
            }
          }
      }
      return Disposables.create()
    }
  }
  
  func fetchReviews(idMovie: Int, page: Int) -> Observable<[MovieReview]> {
    return Observable.create { observer in
      if let requestURL = URL(string: ApiCall.URL_MOVIES_REVIEW(idMovie, page)) {
        AF.request(requestURL, method: .get)
          .validate()
          .responseDecodable(of: MovieReviewResponse.self) {response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.reviews)
            case .failure(let error):
              observer.onError(error)
            }
          }
      }
      return Disposables.create()
    }
  }
  
  func fetchVideo(idMovie: Int) -> Observable<[MovieVideo]> {
    return Observable.create { observer in
      if let requestURL = URL(string: ApiCall.URL_MOVIES_VIDEO(idMovie)) {
        AF.request(requestURL, method: .get)
          .validate()
          .responseDecodable(of: MovieVideoResponse.self) {response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.videos ?? [MovieVideo.default])
            case .failure(let error):
              observer.onError(error)
            }
          }
      }
      return Disposables.create()
    }
  }
}
