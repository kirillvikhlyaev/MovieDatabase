//
//  Extension + UIImage.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 02.09.2022.
//

import UIKit
//MARK: Extension + UIIMageView
extension UIImageView {
    ///Закругление изображения до состояния кружка.
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
