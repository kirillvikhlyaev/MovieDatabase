//
//  SerialDownloadManager.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 31.08.2022.
//

import Foundation

final class SerialDownloadManager  {
    var serials = [Serial]()
    var cast = [Cast]()
    
    static var baseURL = "https://api.themoviedb.org/3/"
    
    
    
    func getPopular() {
        getSerials(serialUrl: .discover)
    }
    

    
//    func getCast(for serial: Serial) {
//        let urlString = "\(Self.baseURL)\(serial.id ?? 100)/credits?api_key=\(API.key)&language=en-US"
//        NetworkManager<CastResponse>.fetch(from: urlString) { (result) in
//            switch result {
//            case .success(let response):
//                self.cast = response.cast
//            case .failure(let err):
//                print(err)
//            }
//        }
   // }
    
    private func getSerials(serialUrl: SerialURL){
        NetworkManager<SerialResponse>.fetch(from: serialUrl.urlString) { (result) in
            switch result {
            case .success(let serialResponse):
                self.serials = serialResponse.results
                print(serialResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
