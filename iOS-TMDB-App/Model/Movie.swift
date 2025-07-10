//
//  Movie.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let voteCount: Int
    let voteAverage: Double
    let runtime: Int?
    let posterPath: String?
    let releaseDate: String?
    let genres: [Genre]?
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String?
}

struct MovieList: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
}
