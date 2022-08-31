//
//  CustomCollectionViewCell.swift
//  MovieDatabase
//
//  Created by Кирилл on 30.08.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "CustomCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with movie: Movie) {
        self.title.text = movie.title
        self.date.text = movie.date
        self.imageView.image = UIImage(named: movie.imageUrl)
    }
}
