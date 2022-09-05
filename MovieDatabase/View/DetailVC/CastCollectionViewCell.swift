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
        let backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.13, alpha: 0.6)
        let titleColor = UIColor(red: 0.09, green: 0.09, blue: 0.13, alpha: 1)
        castImageView.isSkeletonable = true
        castTitle.isSkeletonable = true
        castRole.isSkeletonable = true
        castImageView.showGradientSkeleton(usingGradient: .init(baseColor: backgroundColor), transition: .crossDissolve(3))
        castTitle.showGradientSkeleton(usingGradient: .init(baseColor: titleColor), transition: .crossDissolve(3))
        castRole.showGradientSkeleton(usingGradient: .init(baseColor: titleColor), transition: .crossDissolve(3))
        self.castTitle.text = cast.originalName
        self.castRole.text = cast.character ?? "Актер"
        let url = URL(string: cast.profilePhoto ?? "https://www.viewsontop.com/wp-content/uploads/2020/01/placeholder.png")
        self.castImageView.kf.setImage(with: url)
        castImageView.stopSkeletonAnimation()
        castTitle.stopSkeletonAnimation()
        castRole.stopSkeletonAnimation()
        castImageView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(3))
        castTitle.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(4))
        castRole.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(4))
    }
}
