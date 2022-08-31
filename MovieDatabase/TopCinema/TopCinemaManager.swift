//
//  TopCinemaManager.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 30.08.2022.
//

import Foundation

protocol TopCinemaManagerDelegate: AnyObject {
    func didUpdateTopCinema(_ topCinemaManager: TopCinemaManager, results: TopCinemaModel)
    func didFailWithError(error: Error)
}

struct TopCinemaManager {
    
    let topCinemaURL = "https://api.themoviedb.org/3/discover/movie?api_key=33ad093ed2af268934379de890849085&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    
    weak var delegate: TopCinemaManagerDelegate?
    
    func performRequest() {
        if let url = URL(string: topCinemaURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    print(safeData)
                        if let results = self.parseJSON(safeData) {
                            self.delegate?.didUpdateTopCinema(self, results: results)

                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> TopCinemaModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(TopCinemaModel.self, from: data)
            let id = decodeData.results[0].id
            let originalTitle = decodeData.results[0].originalTitle
            print(id)
            return decodeData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
