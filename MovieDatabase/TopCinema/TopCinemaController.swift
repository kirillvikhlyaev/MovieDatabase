//
//  TopCinemaController.swift
//  MovieDatabase
//
//  Created by Марк Михайлов on 30.08.2022.
//

import UIKit

class TopCinemaController: UIViewController, TopCinemaManagerDelegate {
    func didUpdateTopCinema(_ topCinemaManager: TopCinemaManager, results: TopCinemaModel) {
        
    }
    
    func didFailWithError(error: Error) {
        
    }
    

    var topCinemaManager = TopCinemaManager()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        topCinemaManager.delegate = self
        topCinemaManager.performRequest()

}

}
