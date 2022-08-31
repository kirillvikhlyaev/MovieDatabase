//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Кирилл on 29.08.2022.
//

import UIKit

class MainPageViewController: UITableViewController {
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movies.append(Movie(title: "Batman", date: "2017", imageUrl: "example"))
        movies.append(Movie(title: "Spider-Man", date: "2021", imageUrl: "example"))
        movies.append(Movie(title: "Superman", date: "2015 ", imageUrl: "example"))
        
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configure(with: movies)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
 

}

struct Movie {
    let title: String
    let date: String
    let imageUrl: String
    
}
