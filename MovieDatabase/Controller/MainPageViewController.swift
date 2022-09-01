//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Кирилл on 29.08.2022.
//

import UIKit

class MainPageViewController: UITableViewController {
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var movies = [
            Movie(title: "Spider-Man", date: "2021", imageUrl: "simpleWoman"),
            Movie(title: "Logan", date: "2016", imageUrl: "simpleWoman"),
            Movie(title: "Iron Man", date: "2007", imageUrl: "simpleWoman"),
            Movie(title: "Flash", date: "2017", imageUrl: "simpleWoman"),
            Movie(title: "Avengers", date: "2011", imageUrl: "simpleWoman"),
        ]
        
        categories.append(Category(name: "Популярные фильмы", movies: movies))
        categories.append(Category(name: "Популярные сериалы", movies: movies))
        categories.append(Category(name: "Просмотренные недавно", movies: movies))
        
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        print("indexPath \(indexPath.row)")
        if (indexPath.row == 0) {
            
            cell.configure(with: categories[0])
        }
        if (indexPath.row == 1) {
            cell.configure(with: categories[1])
            
        }
        if (indexPath.row == 2) {
            cell.configure(with: categories[2])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
 

}
