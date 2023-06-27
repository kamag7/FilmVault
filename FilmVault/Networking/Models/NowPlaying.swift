//
//  NowPlaying.swift
//  FilmVault
//
//  Created by magdalena.skawinska on 25/06/2023.
//

import Foundation

struct NowPlayingResponse: Codable {
    let dates: DatesRange
    let page: Int
    let results: [Movie]
}

struct DatesRange: Codable {
    let minimum: String
    let maximum: String
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
