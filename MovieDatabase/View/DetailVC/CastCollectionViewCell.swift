//
//  CastCollectionViewCell.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 01.09.2022.
//
//MARK: Ячейка DetailsVC с актерами
import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castTitle: UILabel!
    @IBOutlet weak var castRole: UILabel!
    
    static let identifier = "CastCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CastCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with movie: Movie) {
        self.castTitle.text = movie.title
        self.castRole.text = movie.release_date
        self.castImageView.image = UIImage(named: movie.posterPath)
    }
}
