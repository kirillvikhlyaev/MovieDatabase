//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Кирилл on 29.08.2022.
//

import UIKit
import Kingfisher

class MovieSelectorViewController: UIViewController {

    
    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var serialCollectionView: UICollectionView!
    @IBOutlet var watchedRecentlyCollectionView: UICollectionView!
    
    var categories = [Category]()
    
    let managerMovie = MovieDownloadManager()
    let managerSerial = SerialDownloadManager()
    
    var movies = [Movie]()
    
    var serials = [Serial]()
    
    var watchedMovies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movies = [
                    Movie(id: 3, title: "Harry Potter", original_language: "", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
                ]
        
        serials = [
            Serial(backdropPath: "", firstAirDate: "", genreIDS: [], id: 0, name: "", originCountry: [], originalLanguage: "", originalName: "", overview: "", popularity: 0, posterPath: "", voteAverage: 0, voteCount: 0)
        ]
        
        movieCollectionView.backgroundColor = .none
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        serialCollectionView.backgroundColor = .none
        serialCollectionView.delegate = self
        serialCollectionView.dataSource = self
        serialCollectionView.register(UINib(nibName: "SerialCell", bundle: nil), forCellWithReuseIdentifier: "SerialCell")
        
        watchedRecentlyCollectionView.backgroundColor = .none
        watchedRecentlyCollectionView.delegate = self
        watchedRecentlyCollectionView.dataSource = self
        watchedRecentlyCollectionView.register(UINib(nibName: "WatchedRecentlyCell", bundle: nil), forCellWithReuseIdentifier: "WatchedRecentlyCell")
        
        managerMovie.delegate = self
        managerMovie.getPopular()
        
        managerSerial.delegate = self
        managerSerial.getPopular()
    }
}

// MARK: - Fetch Films Methods
extension MovieSelectorViewController: MovieFetcher {
    func didUpdateMovies(_ movieManager: MovieDownloadManager, movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.movieCollectionView.reloadData()
            print("Количество загруженных фильмов - \(self.movies.count)")
        }
    }
}

// MARK: - Fetch Serials Methods
extension MovieSelectorViewController: SerialFetcher {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateSeries(_ serialManager: SerialDownloadManager, movies: [Serial]) {
        DispatchQueue.main.async {
            self.serials = movies
            self.serialCollectionView.reloadData()
            print("Количество загруженных сериалов - \(self.serials.count)")
        }
    }
}

extension MovieSelectorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ID фильма: \(movies[indexPath.row].id)")
    }
}

extension MovieSelectorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCollectionView {
            return movies.count
        } else if collectionView == serialCollectionView {
            return serials.count
        } else if collectionView == watchedRecentlyCollectionView {
            return watchedMovies.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == movieCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.movieTitle.text = movies[indexPath.row].title ?? "Harry Potter"
            cell.premiereDate.text = movies[indexPath.row].release_date ?? "2000"
            
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(movies[indexPath.row].posterPath)")
            cell.poster.kf.setImage(with: url)
            return cell
        } else if collectionView == serialCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerialCell", for: indexPath) as! SerialCell
            cell.serialTitle.text = serials[indexPath.row].name
            cell.premiereDate.text = serials[indexPath.row].firstAirDate
            
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(serials[indexPath.row].posterPath)")
            cell.poster.kf.setImage(with: url)
            return cell
        } else if collectionView == watchedRecentlyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchedRecentlyCell", for: indexPath) as! WatchedRecentlyCell
            cell.watchedRecentlyTitle.text = movies[indexPath.row].title ?? "Harry Potter"
            cell.premiereDate.text = movies[indexPath.row].release_date ?? "2000"
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(movies[indexPath.row].posterPath)")
            cell.poster.kf.setImage(with: url)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}