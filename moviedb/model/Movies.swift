//
//  Movies.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation

public struct MovieResponse: Decodable, Hashable {
  public let page: Int?
  public let totalResults: Int?
  public let totalPages: Int?
  public let movie: [Movie]?
  
  internal enum CodingKeys: String, CodingKey {
    case page = "page"
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case movie = "results"
  }
}

public struct Movie: Decodable, Hashable {
  public let id: Int?
  public let title: String?
  public let backdropPath: String?
  public let posterPath: String?
  public let overview: String?
  public let releaseDate: String?
  public let voteAverage: Double?
  public let voteCount: Int?
  
  public var posterURL: String {
    ApiCall.imagePosterUrl + (posterPath ?? "")
  }
  
  public var backdropURL: String {
    ApiCall.imagebackdropUrl + (backdropPath ?? "")
  }
  
  public var voteAveragePercentText: String? {
    return String(format: " %.2f ", voteAverage ?? 0.0)
  }
  
  internal enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case backdropPath = "backdrop_path"
    case posterPath = "poster_path"
    case overview = "overview"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
  
  public static var `default`: Movie {
    Movie(id: 315162, title: "Puss in Boots: The Last Wish",
          backdropPath: "/r9PkFnRUIthgBp2JZZzD380MWZy.jpg",
          posterPath: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg",
          overview: "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives",
          releaseDate: "2022-12-07",
          voteAverage: 8.6, voteCount: 2077
    )
  }
}


