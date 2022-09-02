//
//  DetailsViewController.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 31.08.2022.
//

import UIKit
import WebKit
import Kingfisher
class DetailsViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: IBOutlets
    //buttons
    @IBOutlet weak var favoriteBookMarkButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!
    //Image
    @IBOutlet weak var movieImage: UIImageView!
    //RatingView
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var cosmosRatingView: CosmosView!
    //main labels
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    //secondary labels
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    //table-collection view
    @IBOutlet weak var tableView: UITableView!
    
    var movieId: Int = 0
    
    //MARK: let/var
    ///Bool добавления в израбнное.
    var addedToFavorite = false
    let defaults = UserDefaults.standard
    //    var movies = [Movie]()
    
    let movieManager = MovieDownloadManager()
    let serialManager = SerialDownloadManager()
    
    
    ///Фильмы заглушки
    var movies = [
        Movie(id: 0, title: "SpiderMan", original_language: "SpiderMan", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
        Movie(id: 1, title: "La Casa De Papel", original_language: "SpiderMan", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
        Movie(id: 2, title: "1+1", original_language: "SpiderMan", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: ""),
        Movie(id: 3, title: "Harry Potter", original_language: "SpiderMan", overview: "", poster_path: "", backdrop_path: "", popularity: 0, vote_average: 0, vote_count: 0, video: false, adult: false, release_date: "")
    ]
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkFavorite()
        registerTableView()
        setupRatingStars()
        
        //serialManager.getCast()
        
        //        let url = URL(string: "https://image.tmdb.org/t/p/original/hOrV2fCw2kmSiS4ZMGFPfXqr3lt.jpg")
        //        movieImage.kf.setImage(with: url)
        
        
    }
    
    //MARK: Methods
    ///Проверка наличия имени фильма в UserDefaults.
    private func checkFavorite() {
        if (defaults.value(forKey: "\(NameLabel.text!)") != nil) {
            favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            addedToFavorite = true
            print("При проверке фильм добавлен в избранное")
        } else {
            print("При проверке фильм не добавлен в избранное")
            favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    ///Подписка на делегаты и регистрация Niba
    private func registerTableView() {
        self.tableView.register(CastTableViewCell.nib(), forCellReuseIdentifier: CastTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    ///Количество звёздочек рейтинга для фильма
    private func setupRatingStars() {
        cosmosRatingView.rating = 4.3
        cosmosRatingView.text = "\(4.3)"
    }
    ///Нажатие кнопки закладок
    @IBAction func addToFavoriteButtonPressed(_ sender: UIButton) {
        if addedToFavorite == false {
            UIView.animate(withDuration: 0.3) { [self] in
                print("Adding a \(NameLabel.text!) movie to Favorites")
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                addedToFavorite = true
                UserDefaults.resetStandardUserDefaults()
                defaults.value(forKey: "\(NameLabel.text!)")
                defaults.set(addedToFavorite, forKey: "\(NameLabel.text!)")
            }
            
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                print("remove \(NameLabel.text!) movie from Favorites")
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                defaults.removeObject(forKey: "\(NameLabel.text!)")
                UserDefaults.standard.removeObject(forKey: "\(NameLabel.text!)")
                UserDefaults.resetStandardUserDefaults()
                addedToFavorite = false
            }
        }
    }
    ///Нажатие кнопки просмотра фильма (Работает по прямой ссылке)
    @IBAction func watchButtonPressed(_ sender: UIButton) {
        
        //Сайт заглушка
        let webView : WKWebView = {
            let preferences = WKWebpagePreferences()
            preferences.allowsContentJavaScript = true
            let configuration = WKWebViewConfiguration()
            let webView = WKWebView.init(frame: view.frame, configuration: configuration)
            return webView
        }()
        view.addSubview(webView)
        //        webView.customUserAgent = "iPad/Chrome/SomethingRandom"
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            webView.evaluateJavaScript("document.body.innerHTML") { result, error in
                guard let html = result as? String, error == nil else {
                    return
                }
                print(html)
            }
        }
        
        let adress = "https://www.kinopoisk.ru/film/102383/"
        guard let url = URL(string: adress) else { return }
        let request = URLRequest (url: url)
        webView.load (request)
    }
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension DetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Количество ячеек в вертикали.
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else {
            fatalError("The dequeued cell is not an instance of CastTableViewCell.")
        }
        cell.backgroundColor = UIColor.clear
        cell.configure(with: movies)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}
