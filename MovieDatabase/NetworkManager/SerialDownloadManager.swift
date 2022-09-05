//
//  SerialDownloadManager.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 31.08.2022.
//

import Foundation

protocol SerialFetcher {
    func didUpdateSeries(_ serialManager: SerialDownloadManager, serials: [Serial])
    func didFailWithError(error: Error)
}

protocol SerialCastFetcher {
    func didUpdateCast(_ serialManager: SerialDownloadManager, cast: [Cast])
    func didFailWithError(error: Error)
}

protocol SerialLinkFetcher {
    func didUpdateLink(_ serialManager: SerialDownloadManager, link: SerialOne)
    func didFailWithError(error: Error)
}

final class SerialDownloadManager  {
    var serials = [Serial]()
    var cast = [Cast]()
    var serialOne = SerialOne()
    
    static var baseURL = "https://api.themoviedb.org/3/"
    
    var delegate: SerialFetcher?
    var castDelegate: SerialCastFetcher?
    var linkDelegate: SerialLinkFetcher?
    
    func getPopular() {
        getSerials(serialUrl: .discover)
    }
    
 
    func getCast(for serialId: Int) {
        let urlString = "\(Self.baseURL)tv/\(serialId)/credits?api_key=\(API.key)&language=en-US"
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
    
    func getLink (for serialId: Int) {
        let urlString = "\(Self.baseURL)tv/\(serialId)?api_key=\(API.key)&language=en-US"
        print(urlString)
        NetworkManager<SerialOne>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let response):
                self.serialOne = response
                self.linkDelegate?.didUpdateLink(self, link: self.serialOne)
                print(response)
            case .failure(let err):
                self.linkDelegate?.didFailWithError(error: err)
            }
        }
    }
    

    
    private func getSerials(serialUrl: SerialURL){
        NetworkManager<SerialResponse>.fetch(from: serialUrl.urlString) { (result) in
            switch result {
            case .success(let serialResponse):
                self.serials = serialResponse.results
                self.delegate?.didUpdateSeries(self, serials: self.serials)
            case .failure(let err):
                self.delegate?.didFailWithError(error: err)
            }
        }
    }
}
