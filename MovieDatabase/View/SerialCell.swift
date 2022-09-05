//
//  SerialCell.swift
//  MovieDatabase
//
//  Created by Кирилл on 04.09.2022.
//

import UIKit

class SerialCell: UICollectionViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var serialTitle: UILabel!
    @IBOutlet weak var premiereDate: UILabel!
    @IBOutlet weak var blurView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSetupSkeleton()
         configureHideSkeleton()
    }
    
    func configureSetupSkeleton() {
        let backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.13, alpha: 1)
        poster.isSkeletonable = true
        blurView.isSkeletonable = true
        premiereDate.isSkeletonable = true
        poster.showGradientSkeleton(usingGradient: .init(baseColor: backgroundColor), transition: .crossDissolve(0.4))
        blurView.showGradientSkeleton(usingGradient: .init(baseColor: backgroundColor), transition: .crossDissolve(0.3))
        premiereDate.showGradientSkeleton(usingGradient: .init(baseColor: backgroundColor), transition: .crossDissolve(0.3))
}
    
    func configureHideSkeleton() {
        poster.stopSkeletonAnimation()
        blurView.stopSkeletonAnimation()
        premiereDate.stopSkeletonAnimation()
        poster.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
        blurView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
        premiereDate.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
}

}
