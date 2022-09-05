//
//  SerialURL.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 31.08.2022.
//

import Foundation

enum SerialURL: String {

 
    case discover = "discover/tv"



    public var urlString: String {
        "\(SerialDownloadManager.baseURL)\(self.rawValue)?api_key=\(API.key)&language=en-USsort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0"
    }
}
