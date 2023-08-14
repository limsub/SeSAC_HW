//
//  Struct.swift
//  0811hw
//
//  Created by 임승섭 on 2023/08/14.
//

import Foundation

// MARK: - Welcome
struct TrendMovies: Codable {
    let page, totalPages, totalResults: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let mediaType: MediaType
    let originalLanguage: OriginalLanguage
    let adult: Bool
    let backdropPath, overview: String
    let id: Int
    let releaseDate: String
    let video: Bool
    let originalTitle, title: String
    let popularity: Double
    let posterPath: String
    let genreIDS: [Int]
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case adult
        case backdropPath = "backdrop_path"
        case overview, id
        case releaseDate = "release_date"
        case video
        case originalTitle = "original_title"
        case title, popularity
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case hi = "hi"
    case ja = "ja"
}





// MARK: - Welcome
struct GenreMoives: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
    let id: Int
}
