//
//  ApiCall.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation

struct ApiCall {
  static public let URL_BASE = "https://api.themoviedb.org/3/"
  static public let API_KEY = "967ad60bd20b9b2102526183323e3c3b"
  
  static public let imagePosterUrl = "https://image.tmdb.org/t/p/w500"
  static public let imagebackdropUrl = "https://image.tmdb.org/t/p/original"
  static public let youtubeUrl = "https://www.youtube.com/watch?v="
  static public let imageTumbnailYt = "http://img.youtube.com/vi/"
  static public let imageAvatarUrl = "https://www.gravatar.com/avatar"
  
  
  
  //"\(baseAPIURL)/movie/popular?api_key=\(apiKey)&page=\(page)")
  
  static let URL_MOVIES_GENRE = URL_BASE + "genre/movie/list?api_key=\(API_KEY)"
  
  static let URL_MOVIES_DISCOVER: (Int, Int) -> String = {idGenre, page in
    URL_BASE + "discover/movie?api_key=\(API_KEY)&with_genres=\(idGenre)&page=\(page)"
  }
  
  static let URL_MOVIES_POPULAR: (Int) -> String = { page in
    URL_BASE + "movie/popular?api_key=\(API_KEY)&page=\(page)"
  }
  
  static let URL_MOVIES_REVIEW: (Int, Int) -> String = { idMovie, page in
    URL_BASE + "movie/\(idMovie)/reviews?api_key=\(API_KEY)&page=\(page)"
  }
  
  static let URL_MOVIES_VIDEO: (Int) -> String = { idMovie in
    URL_BASE + "movie/\(idMovie)/videos?api_key=\(API_KEY)"
  }
}
