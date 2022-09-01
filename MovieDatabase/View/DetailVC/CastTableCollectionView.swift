//
//  CollectionTableViewCell.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 01.09.2022.
//

import UIKit

class CastTableCollectionView: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: let/var
    static let identifier = "CastTableCollectionView"
    var movies = [Movie]()
    
    static func nib() -> UINib {
        return UINib(nibName: "CastTableCollectionView", bundle: nil)
    }
    
    //MARK: lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(CastTableCollectionView.nib(), forCellWithReuseIdentifier: CastTableCollectionView.identifier)
        ///Подписка на Delegate и DataSource
        collectionView.delegate = self
        collectionView.dataSource = self
    }

//MARK: Override methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

//MARK: Methods
 public func configure(with movie: [Movie] ) {
     self.movies = movie
    collectionView.reloadData()
}
    
}

//MARK: Extension
extension CastTableCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as! CastCollectionViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  150, height: 250)
    }
    
    
}
