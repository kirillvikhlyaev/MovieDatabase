//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Кирилл on 29.08.2022.
//

import UIKit
import Kingfisher

class MainPageViewController: UITableViewController {
    
    var categories = [Category]()
    
    let managerMovie = MovieDownloadManager()
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movies = [
                    Movie(id: 0, title: "SpiderMan", original_language: "", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
                    Movie(id: 1, title: "La Casa De Papel", original_language: "", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
                    Movie(id: 2, title: "1+1", original_language: "", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
                    Movie(id: 3, title: "Harry Potter", original_language: "", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
                ]
        
        managerMovie.delegate = self
        managerMovie.getPopular()
        
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

extension MainPageViewController: MovieFetcher {
    func didUpdateMovies(_ movieManager: MovieDownloadManager, movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.categories[0] = Category(name: "Популярные фильмы", movies: self.movies)
            self.tableView.reloadData()
            print(self.movies.count)
            //print(self.movies[0].id)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
