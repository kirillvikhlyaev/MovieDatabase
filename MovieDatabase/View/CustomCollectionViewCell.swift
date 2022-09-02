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

    public func configure(with movie: Movie) {
        self.movieId = movie.id ?? 0
        self.title.text = movie.title ?? "title"
        self.date.text = movie.release_date ?? "release_date"
        let url = URL(string: "\(movie.posterPath)")
        self.imageView.kf.setImage(with: url)
    }
}
