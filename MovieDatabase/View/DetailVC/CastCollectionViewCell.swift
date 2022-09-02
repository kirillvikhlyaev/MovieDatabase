//
//  CastCollectionViewCell.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 01.09.2022.
//
//MARK: Ячейка CastCollectionViewCell с актерами
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
    ///Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castImageView.makeRounded()
    }
    ///Конфигурация CastCollectionViewCell
    public func configure(with movie: Movie) {
        self.castTitle.text = movie.title ?? "title"
        self.castRole.text = movie.original_language ?? "original language"
        self.castImageView.image = UIImage(named: movie.posterPath) ?? UIImage(named: "simpleWoman")
    }
}
