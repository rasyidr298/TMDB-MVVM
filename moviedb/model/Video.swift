//
//  Video.swift
//  moviedb
//
//  Created by Rasyid Ridla on 28/01/23.
//

import Foundation

public struct MovieVideoResponse: Decodable {
  public let videos: [MovieVideo]?
  
  internal enum CodingKeys: String, CodingKey {
    case videos = "results"
  }
}

public struct MovieVideo: Decodable {
  public let id: String?
  public let key: String?
  public let name: String?
  public let site: String?
  public let size: Int?
  public let type: String?
  
  public var youtubeURL: URL? {
    guard site == "YouTube" else {
      return nil
    }
    return URL(string: ApiCall.youtubeUrl + (key ?? ""))
  }
  
  internal enum CodingKeys: String, CodingKey {
    case id = "id"
    case key = "key"
    case name = "name"
    case site = "site"
    case size = "size"
    case type = "type"
  }
  
  public static var `default`: MovieVideo {
    MovieVideo(
      id: "63a759abe4b57600a05166d2",
      key: "kpjwc55Bp6I",
      name: "Who Is The Justice Society?",
      site: "YouTube",
      size: 1080,
      type: "Featurette"
    )
  }
}
