//
//  DetailsViewController.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 31.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    //MARK: IBOutlets
    //buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!
    //Image
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    //RatingView
    @IBOutlet weak var starsRatingView: UIView!
    //main labels
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    //secondary labels
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    //MARK: let/var
    var addToFeature = true
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Methods
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        addToFeature = !addToFeature
        if addToFeature {
            bookMarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        } else {
            bookMarkButton.setImage(UIImage(named: "bookmark.fill"), for: .normal)
        }
        
    }
    

}
