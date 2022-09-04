//
//  MovieDownloadManager.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 31.08.2022.

import Foundation

protocol MovieFetcher {
    func didUpdateMovies(_ movieManager: MovieDownloadManager, movies: [Movie])
    func didFailWithError(error: Error)
}

protocol MovieCastFetcher {
    func didUpdateCast(_ movieManager: MovieDownloadManager, cast: [Cast])
    func didFailWithError(error: Error)
}

final class MovieDownloadManager  {
    var movies = [Movie]()
    var cast = [Cast]()
    var movie = Movie()
    
    var delegate: MovieFetcher?
    var castDelegate: MovieCastFetcher?
    
    static var baseURL = "https://api.themoviedb.org/3/"
    
    func getPopular(){
        getMovies(movieUrl: .discover)
    }
    
    func getCast(for movieId: Int) {
        let urlString = "\(Self.baseURL)movie/\(movieId)/credits?api_key=\(API.key)&language=ru-RU"
        NetworkManager<CastResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let response):
                self.cast = response.cast
                self.castDelegate?.didUpdateCast(self, cast: self.cast)
            case .failure(let err):
                self.castDelegate?.didFailWithError(error: err)
            }
        }
    }
    
    private func getMovies(movieUrl: MovieURL){
        NetworkManager<MovieResponse>.fetch(from: movieUrl.urlString) { (result) in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
                self.delegate?.didUpdateMovies(self, movies: self.movies)
            case .failure(let err):
                self.delegate?.didFailWithError(error: err)
            }
        }
    }
}
