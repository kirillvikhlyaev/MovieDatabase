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
    @IBOutlet weak var ratingView: CosmosView!
    //main labels
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    //secondary labels
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var castLabel: UILabel!
    //Collection view
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var mediaObject: Collectable? = nil
    
    //MARK: let/var
    ///Bool добавления в израбнное.
    var addedToFavorite = false
    
    let defaults = UserDefaults.standard
    
    var cast : [Cast] = []
    private var gradient: CAGradientLayer!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        setupGradient()
        checkFavorite()
        print("DetailViewController: я получил - \(mediaObject)")
        registerCollectionView()
        //        setupRatingStars()
        
        if (mediaObject is Movie) {
            let movieObject = mediaObject as! Movie
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(movieObject.posterPath)")
            movieImage.kf.setImage(with: url)
            
            NameLabel.text = movieObject.title
            subnameLabel.text = movieObject.release_date
            ratingView.rating = ((movieObject.vote_average ?? 3.0) / 2)
            ratingView.text = ""
            descriptionText.text = movieObject.overview
            
            let movieManager = MovieDownloadManager()
            movieManager.castDelegate = self
            movieManager.getCast(for: movieObject.id ?? 0)
            movieManager.getLink(for: movieObject.id ?? 0)
            
        } else if (mediaObject is Serial) {
            let serialObject = mediaObject as! Serial
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(serialObject.posterPath)")
            movieImage.kf.setImage(with: url)
            
            NameLabel.text = serialObject.name
            subnameLabel.text = serialObject.firstAirDate
            ratingView.rating = Double(Int(serialObject.voteAverage / 2))
            ratingView.text = ""
            //            String(format: "%.0f", serialObject.voteAverage / 2 )
            descriptionText.text = serialObject.overview
            
            let serialManager = SerialDownloadManager()
            serialManager.castDelegate = self
            serialManager.getCast(for: serialObject.id)
            serialManager.getLink(for: serialObject.id)
            
        } else {
            movieImage.image = UIImage(named: "simpleWoman")
        }
    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = movieImage.bounds
    }
    //MARK: Methods
    ///Проверка наличия имени фильма в UserDefaults.
    private func checkFavorite() {
        if (mediaObject is Movie) {
            let movieObject = mediaObject as! Movie
            if (defaults.value(forKey: "\(movieObject.title ?? "wonderWoman")") != nil) {
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                addedToFavorite = true
                print("При проверке фильм добавлен в избранное")
            }
        } else  if (mediaObject is Serial) {
            let serialObject = mediaObject as! Serial
            if (defaults.value(forKey: "\(serialObject.name ?? "wonderWoman")") != nil) {
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                addedToFavorite = true
                print("При проверке фильм добавлен в избранное")
            }
        } else {
            print("При проверке фильм не добавлен в избранное")
            favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    private func setupGradient() {
        // настройка градиента
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
    ///Количество звёздочек рейтинга для фильма
    private func setupRatingStars() {
        ratingView.rating = 3.8
        ratingView.text = "\(3.8)"
    }
    //MARK: @IBAction
    ///Нажатие кнопки закладок
    @IBAction func addToFavoriteButtonPressed(_ sender: UIButton) {
        
        if (mediaObject is Movie) {
            let movieObject = mediaObject as! Movie
            if addedToFavorite == false {
                UIView.animate(withDuration: 0.3) { [self] in
                    print("Adding a \(NameLabel.text!) movie to Favorites")
                    favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                    addedToFavorite = true
                    UserDefaults.resetStandardUserDefaults()
                    defaults.value(forKey: "\(movieObject.title ?? "Wonder woman")")
                    defaults.set(addedToFavorite, forKey: "\(movieObject.title ?? "Wonder woman")")
                }
            } else if (mediaObject is Serial) {
                let serialObject = mediaObject as! Serial
                print("Adding a \(NameLabel.text!) movie to Favorites")
                favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                addedToFavorite = true
                UserDefaults.resetStandardUserDefaults()
                defaults.value(forKey: "\(serialObject.name ?? "Wonder woman")")
                defaults.set(addedToFavorite, forKey: "\(serialObject.name ?? "Wonder woman")")
            } else {
                UIView.animate(withDuration: 0.3) { [self] in
                    print("remove \(movieObject.title ?? "Wonder woman") movie from Favorites")
                    favoriteBookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                    defaults.removeObject(forKey: "\(movieObject.title ?? "Wonder woman")")
                    UserDefaults.standard.removeObject(forKey: "\(movieObject.title ?? "Wonder woman")")
                    UserDefaults.resetStandardUserDefaults()
                    addedToFavorite = false
                }
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
extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of CastTableViewCell.")
        }
        cell.configure(with: self.cast[indexPath.row])
        cell.backgroundColor = UIColor.clear
        
        return cell
        
    }
    
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        movieImage.alpha = scrollView.contentOffset.y / -91.0
    }
}

extension DetailsViewController: SerialCastFetcher {
    func didUpdateCast(_ serialManager: SerialDownloadManager, cast: [Cast]) {
        print("Количество актеров: \(cast.count)")
        self.cast = cast
        DispatchQueue.main.async {
            self.castCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Выкачка каста не удалась: \(error)")
    }
}

extension DetailsViewController: MovieCastFetcher {
    func didUpdateCast(_ movieManager: MovieDownloadManager, cast: [Cast]) {
        print("Количество актеров: \(cast.count)")
        self.cast = cast
        DispatchQueue.main.async {
            self.castCollectionView.reloadData()
        }
    }
}
