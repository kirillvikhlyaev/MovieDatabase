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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
