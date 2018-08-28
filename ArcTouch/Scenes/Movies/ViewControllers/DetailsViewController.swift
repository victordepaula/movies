//
//  DetailsViewController.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 26/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import UIKit
import RxSwift

enum TypeTrailer :  String {
    case trailer = "Trailer"
    case clip = "Clip"
}

class DetailsViewController: UIViewController {
    
    //Mark:- IBOutlets
    @IBOutlet weak var blurImageView: UIImageView! {
        didSet {
            blurImageView.addBlurEffect()
        }
    }
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UILabel! {
        didSet {
            self.descriptionTextView.text = ""
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = ""
        }
    }
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            self.webView.delegate = self
        }
    }

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    //Mark:- Properties
    var movieId : Int64?
    var viewModel =  MoviesViewModel()
    var disposeBag = DisposeBag()
    var constraint : CGFloat  = 0.0
    
    //Mark:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMovieById()
        self.constraint = heightConstraint.constant
        self.heightConstraint.constant = 0.0
    }
    
    //Mark:- IBActions
    @IBAction func trailerTapped(_ sender: UIButton) {
        if self.viewModel.numberOfTrailers == 0 {
            self.getVideoMovie()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Mark:- Misc
    func setup() {
        if let element = self.viewModel.moviesDetails {
            if let image = element.poster_path {
                let avatar = image.getUrlImage()
                if let url = URL(string: avatar) {
                    self.movieImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
                    self.blurImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
                }
            }
            element.genres?.forEach({
                if let genre = $0.name {
                    self.genreLabel.text?.append(" " + genre)
                }
            })
            if let description = element.overview{
                self.descriptionTextView.text = description
            }
            if let title = element.title {
                titleLabel.text = title
            }
            if let dateRec = element.release_date {
                if let dateConvert = Date().new(from: dateRec, format: "yyyy-MM-dd") {
                    self.dateLabel.text = dateConvert.dateToString()
                }
                
            }
        }
    }
    
    func collapsedExpandableView() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options:UIViewAnimationOptions.showHideTransitionViews, animations: { () -> Void in
            self.heightConstraint.constant = CGFloat(self.constraint)
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        })
    }
    
    func setupVideo() {
        if let videoRec = self.viewModel.videosResponse?.results {
            if  videoRec.count > 0 {
                if let videoUrl = videoRec.filter({$0.type == TypeTrailer.trailer.rawValue}).first {
                    if let urlRec = videoUrl.key {
                        if let url = URL(string: "http://www.youtube.com/embed/" + urlRec  + "?autoplay=1&vq=small") {
                            let urlRes = URLRequest(url: url)
                            webView.loadRequest(urlRes)
                        }
                    }
                }
               collapsedExpandableView()
            }
        }
    }
}

// MARK: - Instantiation
extension DetailsViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> DetailsViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! DetailsViewController
    }
}

//Mark:- Call Services
extension DetailsViewController {
    func getMovieById() {
        if let idRec = self.movieId {
            self.view.startLoading()
            viewModel.getMovieById(moviesId: String(describing:idRec))
                .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                    print(service)
                    self.setup()
                }, onError: { (error) in
                    self.navigationController?.popViewController(animated: true)
                }, onCompleted: {
                }, onDisposed: {
                    self.view.stopLoading()
                }).disposed(by: disposeBag)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getVideoMovie() {
        if let idRec = self.movieId {
            self.view.startLoading()
            viewModel.getVideoByMovie(moviesId: String(describing: idRec))
                .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                    print(service)
                    self.setupVideo()
                }, onError: { (error) in
                    self.showAlert(for: error)
                }, onCompleted: {
                }, onDisposed: {
                    self.view.stopLoading()
                }).disposed(by: disposeBag)
        }
    }
}


extension DetailsViewController :  UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.webView.startLoading()
    }
    func webViewDidFinishLoad(_ webView: UIWebView)  {
        self.webView.stopLoadingWebView()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.webView.stopLoadingWebView()
    }
}

