//
//  Movie.swift
//  moviedb
//
//  Created by Rasyid Ridla on 23/11/22.
//

import Foundation

public struct MovieResponse: Codable {
  public let page: Int
  public let totalResults: Int
  public let totalPages: Int
  public let results: [Movie]
}

public struct MovieVideoResponse: Codable {
  public let results: [MovieVideo]
}

public struct MovieReviewResponse: Codable {
  public let results: [MovieReview]
}


public struct Movie: Codable {
  
  public let id: Int
  public let title: String
  public let backdropPath: String?
  public let posterPath: String?
  public let overview: String
  public let releaseDate: Date
  public let voteAverage: Double
  public let voteCount: Int
  public var posterURL: URL {
    return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
  }
  
  public var backdropURL: URL {
    return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
  }
  
  public var voteAveragePercentText: String {
    return "\(Int(voteAverage * 10))%"
  }
}

public struct MovieVideo: Codable {
  public let id: String
  public let key: String
  public let name: String
  public let site: String
  public let size: Int
  public let type: String
  
  public var youtubeURL: URL? {
    guard site == "YouTube" else {
      return nil
    }
    return URL(string: "https://www.youtube.com/watch?v=\(key)")
  }
  
  public var youtubeTumbnail: URL? {
    guard site == "YouTube" else {
      return nil
    }
    return URL(string: "http://img.youtube.com/vi/\(key)/1.jpg")
  }
}

public struct MovieReview: Codable {
  public let author: String
  public let content: String
}
