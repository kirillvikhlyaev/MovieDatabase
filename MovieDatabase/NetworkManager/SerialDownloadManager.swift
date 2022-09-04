//
//  SerialDownloadManager.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 31.08.2022.
//

import Foundation

protocol SerialFetcher {
    func didUpdateSeries(_ serialManager: SerialDownloadManager, movies: [Serial])
    func didFailWithError(error: Error)
}

final class SerialDownloadManager  {
    var serials = [Serial]()
    var cast = [Cast]()
    
    static var baseURL = "https://api.themoviedb.org/3/"
    
    var delegate: SerialFetcher?
    
    func getPopular() {
        getSerials(serialUrl: .discover)
    }
    
    //(serial.id ?? 100)
    func getCast(for serial: Serial) {
        let urlString = "\(Self.baseURL)tv/\(serial.id)/credits?api_key=\(API.key)&language=en-US"
        NetworkManager<CastResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let response):
                self.cast = response.cast
            case .failure(let err):
                self.delegate?.didFailWithError(error: err)
            }
        }
    }
    
    private func getSerials(serialUrl: SerialURL){
        NetworkManager<SerialResponse>.fetch(from: serialUrl.urlString) { (result) in
            switch result {
            case .success(let serialResponse):
                self.serials = serialResponse.results
                self.delegate?.didUpdateSeries(self, movies: self.serials)
            case .failure(let err):
                self.delegate?.didFailWithError(error: err)
            }
        }
    }
}
