//
//  CollectionTableViewCell.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 01.09.2022.
//

import UIKit
//MARK: Ячейка CastTableViewCell
class CastTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: let/var
    var cast = [Cast]()
    
    static let identifier = "CastTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CastTableViewCell", bundle: nil)
    }
    
    //MARK: lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(CastCollectionViewCell.nib(), forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        ///Подписка на Delegate и DataSource
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: Override methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: Methods
    public func configure(with cast: [Cast]) {
        self.cast = cast
        collectionView.reloadData()
    }
}

//MARK: Extension
extension CastTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //количество ячеек вширь
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of CastCollectionViewCell.")
        }
        cell.backgroundColor = UIColor.clear
//        cell.configure(with: cast[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  100, height: 135)
    }
    
    
}
