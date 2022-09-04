//
//  CollectionTableViewCell.swift
//  MovieDatabase
//
//  Created by Кирилл on 30.08.2022.
//

import UIKit


protocol CollectionViewDelegate {
    func cellTaped(data: Int)
}

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate,  UICollectionViewDataSource {
    
    static let identifier = "CollectionTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleOfCategory: UILabel!
    
    var category = Category(name: "", movies: [])

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(CustomCollectionViewCell.nib(), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with category: Category) {
        self.category = category
        self.titleOfCategory.text = category.name
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(with: category.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
