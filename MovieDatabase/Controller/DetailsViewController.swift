//
//  DetailsViewController.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 31.08.2022.
//

import UIKit
import WebKit
import Kingfisher

final class DetailsViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: IB Outlets
    //buttons
    @IBOutlet weak var favoriteBookMarkButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!
    //Image
    @IBOutlet weak var movieImage: UIImageView!
    //RatingView
    @IBOutlet weak var ratingView: CosmosView!
    //main labels
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    //secondary labels
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var castLabel: UILabel!
    //Collection view
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    
    
    //MARK: - Private Properties
    private  var addedToFavorite = false
    private let defaults = UserDefaults.standard
    private var cast = [Cast]()
    
    var mediaObject: Collectable? = nil
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        print("DetailViewController: я получил - \(mediaObject!)")
        
        ///Проверяем Апи
        if (mediaObject is Movie) {
            updateUIMovie()
        } else if (mediaObject is Serial) {
            updateUISerial()
        } else {
            movieImage.image = UIImage(named: "simpleWoman")
        }
        
        setupGradient()
        checkFavorite()
        registerCollectionView()
        
    }
    
    // MARK: - Private Methods
    private func updateUIMovie() {
        let movieObject = mediaObject as! Movie
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(movieObject.posterPath)")
        movieImage.kf.setImage(with: url)
        NameLabel.text = movieObject.title
        subnameLabel.text = movieObject.release_date
        ratingView.rating = ((movieObject.vote_average ?? 3.0) / 2)
        descriptionText.text = movieObject.overview
    }
    private func updateUISerial() {
        let serialObject = mediaObject as! Serial
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(serialObject.posterPath)")
        movieImage.kf.setImage(with: url)
        
        NameLabel.text = serialObject.name
        subnameLabel.text = serialObject.firstAirDate
        ratingView.rating = Double(Int(serialObject.voteAverage / 2))
        print("")
        descriptionText.text = serialObject.overview
    }
    ///Проверка наличия имени фильма в избранном.
    private func checkFavorite() {
        if (mediaObject is Movie) {
            let movieObject = mediaObject as! Movie
            if (defaults.value(forKey: "\(movieObject.title ?? "NIL")") != nil) {
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                addedToFavorite = true
                print("При проверке фильм добавлен в избранные фильмы")
            }
        } else  if (mediaObject is Serial) {
            let serialObject = mediaObject as! Serial
            if (defaults.value(forKey: "\(serialObject.name )") != nil) {
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                addedToFavorite = true
                print("При проверке фильм добавлен в избранные сериалы")
            }
        } else {
            print("При проверке фильм не добавлен в избранное")
            favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    // настройка градиента
    private func setupGradient() {
        var gradient: CAGradientLayer!
        gradient = CAGradientLayer()
        gradient.frame = movieImage.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.4, 1, 0.9, 1.0]
        movieImage.layer.mask = gradient
    }
    ///Подписка на делегаты и регистрация Niba
    private func registerCollectionView() {
        castCollectionView.register(CastCollectionViewCell.nib(), forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        castCollectionView.backgroundColor = .none
        castCollectionView.dataSource = self
    }
    
    //MARK: @IBAction
    ///Нажатие кнопки закладок
    @IBAction func addToFavoriteButtonPressed(_ sender: UIButton) {
        
        if (mediaObject is Movie) && addedToFavorite == false {
            let movieObject = mediaObject as! Movie
            
            defaults.value(forKey: "\(movieObject.title ?? "Film")")
            defaults.set(addedToFavorite, forKey: "\(movieObject.title ?? "Film")")
            print("Adding a \(movieObject.title) movie to Favorites")
            
            addedToFavorite = true
            UserDefaults.resetStandardUserDefaults()
            
            UIView.animate(withDuration: 0.3) { [self] in
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            
        } else if (mediaObject is Serial) && addedToFavorite == false {
            let serialObject = mediaObject as! Serial
            
            defaults.value(forKey: "\(serialObject.name)")
            defaults.set(addedToFavorite, forKey: "\(serialObject.name)")
            print("Adding a \(serialObject.name) Serial to Favorites")
            
            addedToFavorite = true
            UserDefaults.resetStandardUserDefaults()
            
            UIView.animate(withDuration: 0.3) { [self] in
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            
            
        } else if addedToFavorite == true {
            if (mediaObject is Movie) {
                let movieObject = mediaObject as! Movie
                defaults.removeObject(forKey: "\(movieObject.title ?? "Film")")
                print("remove \(movieObject.title ?? "Film") Movie from Favorites")
                
            } else if (mediaObject is Serial) {
                let serialObject = mediaObject as! Serial
                defaults.removeObject(forKey: "\(serialObject.name )")
            }
            UIView.animate(withDuration: 0.3) { [self] in
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
            UserDefaults.resetStandardUserDefaults()
            addedToFavorite = false
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
extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of CastTableViewCell.")
        }
        cell.backgroundColor = UIColor.clear
        
        return cell
        
    }
    
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        movieImage.alpha = scrollView.contentOffset.y / -91.0
    }
}
