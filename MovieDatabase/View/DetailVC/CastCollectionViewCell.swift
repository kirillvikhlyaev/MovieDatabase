//
//  CastCollectionViewCell.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 01.09.2022.
//
//MARK: Ячейка CastCollectionViewCell с актерами
import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castTitle: UILabel!
    @IBOutlet weak var castRole: UILabel!
    var casst = [Cast]()
    static let identifier = "CastCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CastCollectionViewCell", bundle: nil)
    }
    ///Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        castImageView.kf.indicatorType = .activity
        castImageView.makeRounded()
    }
    ///Конфигурация CastCollectionViewCell
    public func configure(with cast: Cast) {
        self.castTitle.text = cast.originalName
        self.castRole.text = cast.character ?? "Актер"
        let url = URL(string: cast.profilePhoto ?? "https://www.viewsontop.com/wp-content/uploads/2020/01/placeholder.png")
        self.castImageView.kf.setImage(with: url)
    }
}
