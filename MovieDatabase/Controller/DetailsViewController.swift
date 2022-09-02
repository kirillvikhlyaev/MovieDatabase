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
    @IBOutlet weak var blurView: UIVisualEffectView!
    //RatingView
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
    var addedToFavorite = false
    var movies = [Movie]()
    
    let movieManager = MovieDownloadManager()
    let serialManager = SerialDownloadManager()

    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        setupRatingStars()
        
        //serialManager.getCast()
        
//        let url = URL(string: "https://image.tmdb.org/t/p/original/hOrV2fCw2kmSiS4ZMGFPfXqr3lt.jpg")
//        movieImage.kf.setImage(with: url)
        
    
    }
    
    //MARK: Methods
    private func registerTableView() {
        tableView.register(CastTableCollectionView.nib(), forCellReuseIdentifier: CastTableCollectionView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRatingStars() {
        cosmosRatingView.rating = 4.3
        cosmosRatingView.text = "\(4.3)"
    }
    
    @IBAction func addToFavoriteButtonPressed(_ sender: UIButton) {
        if addedToFavorite == false {
            UIView.animate(withDuration: 0.3) { [self] in
                print("Adding a \(NameLabel.text!) movie to Favorites")
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                addedToFavorite = true
            }
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                print("remove \(NameLabel.text!) movie from Favorites")
                self.favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                addedToFavorite = false
            }
        }
    }
    
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
//MARK: Extension
extension DetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastTableCollectionView.identifier, for: indexPath) as! CastTableCollectionView
        cell.configure(with: movies)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
