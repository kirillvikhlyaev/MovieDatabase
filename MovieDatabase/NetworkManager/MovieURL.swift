//
//  MovieURL.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 31.08.2022.


import Foundation

enum MovieURL: String {

    
    case images = "images"
    case discover = "discover/movie"


    public var urlString: String {
        "\(MovieDownloadManager.baseURL)\(self.rawValue)?api_key=\(API.key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    }
}


