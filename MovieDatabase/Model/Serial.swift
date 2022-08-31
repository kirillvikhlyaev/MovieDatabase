////
////  Serial.swift
////  MovieDatabase
////
////  Created by Марк Михайлов on 31.08.2022.
////
//
import Foundation

//struct S: Codable, Identifiable {
//    let adult: Bool?
//    let backdrop_path: String?
//    let first_air_date: String?
//    let homepage: String?
//    let id: Int?
//    let in_production: Bool?
//    let languages: [String]?
//    let last_air_date: String?
//    let name: String?
//    let overview: String?
//    let poster_path: String?
//}
//
//import Foundation
//
//// MARK: - Welcome
//struct Ser: Codable {
//    let adult: Bool
//    let backdropPath: String
//    let createdBy: [CreatedBy]
//    let episodeRunTime: [Int]
//    let firstAirDate: String
//    let genres: [Genre]
//    let homepage: String
//    let id: Int
//    let inProduction: Bool
//    let languages: [String]
//    let lastAirDate: String
//    let lastEpisodeToAir: LastEpisodeToAir
//    let name: String
//    let nextEpisodeToAir: String?
//    let networks: [Network]
//    let numberOfEpisodes, numberOfSeasons: Int
//    let originCountry: [String]
//    let originalLanguage, originalName, overview: String
//    let popularity: Double
//    let posterPath: String
//    let productionCompanies: [Network]
//    let productionCountries: [String]
//    let seasons: [Season]
//    let spokenLanguages: [SpokenLanguage]
//    let status, tagline, type: String
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case createdBy = "created_by"
//        case episodeRunTime = "episode_run_time"
//        case firstAirDate = "first_air_date"
//        case genres, homepage, id
//        case inProduction = "in_production"
//        case languages
//        case lastAirDate = "last_air_date"
//        case lastEpisodeToAir = "last_episode_to_air"
//        case name
//        case nextEpisodeToAir = "next_episode_to_air"
//        case networks
//        case numberOfEpisodes = "number_of_episodes"
//        case numberOfSeasons = "number_of_seasons"
//        case originCountry = "origin_country"
//        case originalLanguage = "original_language"
//        case originalName = "original_name"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
//        case productionCountries = "production_countries"
//        case seasons
//        case spokenLanguages = "spoken_languages"
//        case status, tagline, type
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
//
//// MARK: - CreatedBy
//struct CreatedBy: Codable {
//    let id: Int
//    let creditID, name: String
//    let gender: Int
//    let profilePath: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case creditID = "credit_id"
//        case name, gender
//        case profilePath = "profile_path"
//    }
//}
//
//// MARK: - Genre
//struct Genre: Codable {
//    let id: Int
//    let name: String
//}
//
//// MARK: - LastEpisodeToAir
//struct LastEpisodeToAir: Codable {
//    let airDate: String
//    let episodeNumber, id: Int
//    let name, overview, productionCode: String
//    let runtime: String?
//    let seasonNumber, showID: Int
//    let stillPath: String
//    let voteAverage, voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case airDate = "air_date"
//        case episodeNumber = "episode_number"
//        case id, name, overview
//        case productionCode = "production_code"
//        case runtime
//        case seasonNumber = "season_number"
//        case showID = "show_id"
//        case stillPath = "still_path"
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
//
//// MARK: - Network
//struct Network: Codable {
//    let id: Int
//    let name, logoPath, originCountry: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case logoPath = "logo_path"
//        case originCountry = "origin_country"
//    }
//}
//
//// MARK: - Season
//struct Season: Codable {
//    let airDate: String?
//    let episodeCount, id: Int
//    let name, overview: String
//    let posterPath: String?
//    let seasonNumber: Int
//
//    enum CodingKeys: String, CodingKey {
//        case airDate = "air_date"
//        case episodeCount = "episode_count"
//        case id, name, overview
//        case posterPath = "poster_path"
//        case seasonNumber = "season_number"
//    }
//}
//
//// MARK: - SpokenLanguage
//struct SpokenLanguage: Codable {
//    let englishName, iso639_1, name: String
//
//    enum CodingKeys: String, CodingKey {
//        case englishName = "english_name"
//        case iso639_1 = "iso_639_1"
//        case name
//    }
//}



// MARK: - Welcome
struct SerialResponse: Codable {
    let page: Int
    let results: [Serial]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Serial: Codable {
    let backdropPath, firstAirDate: String
    let genreIDS: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
