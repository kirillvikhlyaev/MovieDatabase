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
    
    var mediaObject: Collectable? = nil
    
    //MARK: let/var
    ///Bool добавления в израбнное.
    var addedToFavorite = false
    
    let defaults = UserDefaults.standard
    
    var cast = [Cast]()
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        checkFavorite()
        print("DetailViewController: я получил - \(mediaObject)")
        registerTableView()
        setupRatingStars()
        
        if (mediaObject is Movie) {
            let movieObject = mediaObject as! Movie
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(movieObject.posterPath)")
            movieImage.kf.setImage(with: url)
            
            NameLabel.text = movieObject.title
            subnameLabel.text = movieObject.release_date
            
            descriptionLabel.text = movieObject.overview
        } else if (mediaObject is Serial) {
            let serialObject = mediaObject as! Serial
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(serialObject.posterPath)")
            movieImage.kf.setImage(with: url)
            
            NameLabel.text = serialObject.name
            subnameLabel.text = serialObject.firstAirDate
            
            descriptionLabel.text = serialObject.overview
        } else {
            movieImage.image = UIImage(named: "simpleWoman")
        }
        
        //serialManager.getCast()
    // if let url = URL(string: "\(movies[12])") {
      //            movieImage.kf.setImage(with: url)
      //            }
      //        else {
      //            let url2 = URL(string: "https://image.tmdb.org/t/p/original/\(serials[7])")
      //                movieImage.kf.setImage(with: url2)
      //            }
    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = movieImage.bounds
    }
//      
    
    
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
    private func setupGradient() {
        // настройка градиента
        gradient = CAGradientLayer()
        gradient.frame = movieImage.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.4, 0.8, 0.9, 1.0]
        movieImage.layer.mask = gradient
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
    //MARK: @IBActionЧ
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
        cell.configure(with: cast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}
