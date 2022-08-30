//
//  CollectionTableViewCell.swift
//  MovieDatabase
//
//  Created by Кирилл on 30.08.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate,  UICollectionViewDataSource {
    
    static let identifier = "CollectionTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    var movies = [Movie]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(CustomCollectionViewCell.nib(), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with movie: [Movie] ) {
        self.movies = movie
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  150, height: 250)
    }
    
    
}
