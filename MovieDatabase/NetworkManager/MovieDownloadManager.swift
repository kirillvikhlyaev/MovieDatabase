//
//  MovieDownloadManager.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 31.08.2022.

import Foundation

final class MovieDownloadManager  {
    var movies = [Movie]()
    var cast = [Cast]()
    var movie = Movie()
    
    static var baseURL = "https://api.themoviedb.org/3/"
    
    func getPopular(){
        getMovies(movieUrl: .discover)
    }
    
    
    //(movie.id ?? 100)
    func getCast(for movie: Movie) {
        let urlString = "\(Self.baseURL)movie/\(movie.id ?? 100)/credits?api_key=\(API.key)&language=en-US"
        NetworkManager<CastResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let response):
                self.cast = response.cast
                print(response.cast)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func getMovies(movieUrl: MovieURL){
        NetworkManager<MovieResponse>.fetch(from: movieUrl.urlString) { (result) in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
                print(movieResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
