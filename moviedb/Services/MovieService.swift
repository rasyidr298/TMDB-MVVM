//
//  MovieStore.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation

public enum MovieError: Error {
  case apiError
  case invalidEndpoint
  case invalidResponse
  case noData
  case serializationError
}

protocol MovieServiceProtocol {
  func fetchMovies(page: Int,  completionHandler: @escaping (Result<MovieResponse, Error>) -> Void)
  func fetchMovieVideo(idMovie: Int,  completionHandler: @escaping (Result<MovieVideoResponse, Error>) -> Void)
  func fetchMovieReview(idMovie: Int,  completionHandler: @escaping (Result<MovieReviewResponse, Error>) -> Void)
}

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
  
  
  func fetchMovies(page: Int,  completionHandler: @escaping (Result<MovieResponse, Error>) -> Void) {
    
    guard let urlComponents = URLComponents(string: "\(baseAPIURL)/movie/popular?api_key=\(apiKey)&page=\(page)") else {
      completionHandler(.failure(MovieError.invalidEndpoint))
      return
    }
    
    guard let url = urlComponents.url else {
      completionHandler(.failure(MovieError.invalidEndpoint))
      return
    }
    
    urlSession.dataTask(with: url) { (data, response, error) in
      if error != nil {
        completionHandler(.failure(MovieError.apiError))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        completionHandler(.failure(MovieError.invalidResponse))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(MovieError.noData))
        return
      }
      
      do {
        let moviesResponse = try self.jsonDecoder.decode(MovieResponse.self, from: data)
        DispatchQueue.main.async {
          completionHandler(.success(moviesResponse))
        }
      } catch {
        completionHandler(.failure(MovieError.serializationError))
      }
    }.resume()
  }
  
  func fetchMovieVideo(idMovie: Int,  completionHandler: @escaping (Result<MovieVideoResponse, Error>) -> Void) {
    guard let urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(idMovie)/videos?api_key=\(apiKey)") else {
      completionHandler(.failure(MovieError.invalidEndpoint))
      return
    }
    
    guard let url = urlComponents.url else {
      completionHandler(.failure(MovieError.invalidEndpoint))
      return
    }
    
    urlSession.dataTask(with: url) { (data, response, error) in
      if error != nil {
        completionHandler(.failure(MovieError.apiError))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        completionHandler(.failure(MovieError.invalidResponse))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(MovieError.noData))
        return
      }
      
      do {
        let moviesResponse = try self.jsonDecoder.decode(MovieVideoResponse.self, from: data)
        DispatchQueue.main.async {
          completionHandler(.success(moviesResponse))
        }
      } catch {
        completionHandler(.failure(MovieError.serializationError))
      }
    }.resume()
  }
  
  func fetchMovieReview(idMovie: Int,  completionHandler: @escaping (Result<MovieReviewResponse, Error>) -> Void) {
    guard let urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(idMovie)/reviews?api_key=\(apiKey)") else {
      completionHandler(.failure(MovieError.invalidEndpoint))
      return
    }
    
    guard let url = urlComponents.url else {
      completionHandler(.failure(MovieError.invalidEndpoint))
      return
    }
    
    urlSession.dataTask(with: url) { (data, response, error) in
      if error != nil {
        completionHandler(.failure(MovieError.apiError))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
        completionHandler(.failure(MovieError.invalidResponse))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(MovieError.noData))
        return
      }
      
      do {
        let moviesResponse = try self.jsonDecoder.decode(MovieReviewResponse.self, from: data)
        DispatchQueue.main.async {
          completionHandler(.success(moviesResponse))
        }
      } catch {
        completionHandler(.failure(MovieError.serializationError))
      }
    }.resume()
    
  }
}
