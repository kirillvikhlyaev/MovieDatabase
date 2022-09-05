//
//  MovieCell.swift
//  MovieDatabase
//
//  Created by Кирилл on 04.09.2022.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var premiereDate: UILabel!
    @IBOutlet weak var blurView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       configureSetupSkeleton()
        configureHideSkeleton()
    }
    func configureSetupSkeleton() {
        let backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.13, alpha: 0.6)
        let titleColor = UIColor(red: 0.09, green: 0.09, blue: 0.13, alpha: 1)
        poster.isSkeletonable = true
        blurView.isSkeletonable = true
        premiereDate.isSkeletonable = true
        poster.showGradientSkeleton(usingGradient: .init(baseColor: backgroundColor), transition: .crossDissolve(3))
        blurView.showGradientSkeleton(usingGradient: .init(baseColor: titleColor), transition: .crossDissolve(3))
        premiereDate.showGradientSkeleton(usingGradient: .init(baseColor: titleColor), transition: .crossDissolve(3))
}
    func configureHideSkeleton() {
        poster.stopSkeletonAnimation()
        blurView.stopSkeletonAnimation()
        premiereDate.stopSkeletonAnimation()
        poster.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(3))
        blurView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(4))
        premiereDate.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(4))
}

}
