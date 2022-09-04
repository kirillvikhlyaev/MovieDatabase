//
//  CustomCollectionViewCell.swift
//  MovieDatabase
//
//  Created by Кирилл on 30.08.2022.
//

import UIKit
import Kingfisher


class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var movieId: Int = 0
    
    static let identifier = "CustomCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    public func configure(with movie: Collectable) {
        if (movie is Movie) {
            let movieObject = movie as! Movie
            self.movieId = movieObject.id ?? 0
            self.title.text = movieObject.title ?? "title"
            self.date.text = movieObject.release_date ?? "release_date"
            
            let url = URL(string: "\(movieObject.posterPath)")
            
            self.imageView.kf.setImage(with: url)
        } else if (movie is Serial) {
            let serialObject = movie as! Serial
            self.movieId = serialObject.id
            self.title.text = serialObject.name
            self.date.text = "\(serialObject.popularity)"
            
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(serialObject.posterPath)")
            
            self.imageView.kf.setImage(with: url)
        }
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
    }
    
}
