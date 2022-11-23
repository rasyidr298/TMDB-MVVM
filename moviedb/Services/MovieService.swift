//
//  MovieStore.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation

public class MovieService: MovieServiceProtocol {
  public static let shared = MovieService()
  private let urlSession = URLSession.shared
  private init() {}
  private let apiKey = "967ad60bd20b9b2102526183323e3c3b"
  private let baseAPIURL = "https://api.themoviedb.org/3"
  
  private let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    return jsonDecoder
  }()
  
  
  func fetchMovies(page: Int, successHandler: @escaping (MovieResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
    
    guard let urlComponents = URLComponents(string: "\(baseAPIURL)/movie/popular?api_key=\(apiKey)&page=\(page)") else {
      errorHandler(MovieError.invalidEndpoint)
      return
    }
    
    guard let url = urlComponents.url else {
      errorHandler(MovieError.invalidEndpoint)
      return
    }
    
    urlSession.dataTask(with: url) { (data, response, error) in
      if error != nil {
        self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
        return
      }
      
      guard let data = data else {
        self.handleError(errorHandler: errorHandler, error: MovieError.noData)
        return
      }
      
      do {
        let moviesResponse = try self.jsonDecoder.decode(MovieResponse.self, from: data)
        DispatchQueue.main.async {
          successHandler(moviesResponse)
        }
      } catch {
        self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
      }
    }.resume()
  }
  
  func fetchMovieVideo(idMovie: Int, successHandler: @escaping (MovieVideoResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
    guard let urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(idMovie)/videos?api_key=\(apiKey)") else {
      errorHandler(MovieError.invalidEndpoint)
      return
    }
    
    guard let url = urlComponents.url else {
      errorHandler(MovieError.invalidEndpoint)
      return
    }
    
    urlSession.dataTask(with: url) { (data, response, error) in
      if error != nil {
        self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
        return
      }
      
      guard let data = data else {
        self.handleError(errorHandler: errorHandler, error: MovieError.noData)
        return
      }
      
      do {
        let moviesResponse = try self.jsonDecoder.decode(MovieVideoResponse.self, from: data)
        DispatchQueue.main.async {
          successHandler(moviesResponse)
        }
      } catch {
        self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
      }
    }.resume()
  }
  
  func fetchMovieReview(idMovie: Int, successHandler: @escaping (MovieReviewResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
    guard let urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(idMovie)/reviews?api_key=\(apiKey)") else {
      errorHandler(MovieError.invalidEndpoint)
      return
    }
    
    guard let url = urlComponents.url else {
      errorHandler(MovieError.invalidEndpoint)
      return
    }
    
    urlSession.dataTask(with: url) { (data, response, error) in
      if error != nil {
        self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
        return
      }
      
      guard let data = data else {
        self.handleError(errorHandler: errorHandler, error: MovieError.noData)
        return
      }
      
      do {
        let moviesResponse = try self.jsonDecoder.decode(MovieReviewResponse.self, from: data)
        DispatchQueue.main.async {
          successHandler(moviesResponse)
        }
      } catch {
        self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
      }
    }.resume()
    
  }
  
  
  private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
    DispatchQueue.main.async {
      errorHandler(error)
    }
  }
}

public enum MovieError: Error {
  case apiError
  case invalidEndpoint
  case invalidResponse
  case noData
  case serializationError
}

protocol MovieServiceProtocol {
  func fetchMovies(page: Int, successHandler: @escaping (_ response: MovieResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
  
  func fetchMovieVideo(idMovie: Int, successHandler: @escaping (_ response: MovieVideoResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
  
  func fetchMovieReview(idMovie: Int, successHandler: @escaping (_ response: MovieReviewResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}
