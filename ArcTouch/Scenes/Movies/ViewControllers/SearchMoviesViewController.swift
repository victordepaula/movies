//
//  SearchMoviesViewController.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 26/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import UIKit
import RxSwift

class SearchMoviesViewController: UIViewController {
    //Mark:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.enablesReturnKeyAutomatically = true
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    //Mark:- Properties
    var disposeBag  = DisposeBag()
    var viewModel = MoviesViewModel()
    var page = 1
    let router = MoviesRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//Mark: -  UICOllectionView Delegates and DataSources
extension SearchMoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesSearchCollectionViewCell.identifier, for: indexPath) as? MoviesSearchCollectionViewCell {
            if let movie = self.viewModel.movieForIndexPath(for: indexPath) {
                cell.setupCel(movie: movie)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, 3 - 1) * horizontalSpacing) / 3
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            return flowLayout.itemSize
        }
    
        return CGSize(width: (collectionView.bounds.width-10)/3.25, height: 124)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let count = self.viewModel.movies?.total_results, let totalPages = self.viewModel.movies?.total_pages {
            let countList = self.viewModel.numberOfMovies
            if  indexPath ==  collectionView.lastIndexPath() {
                if countList > 0 {
                    if indexPath.row == countList - 1 {
                        if countList < count && page < totalPages {
                            self.page += 1
                            if let text = searchBar.text {
                                self.getMoviesSearch(moviesName: text, page: String(describing:self.page))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = self.viewModel.movieForIndexPath(for: indexPath) {
            if let id = movie.id {
                 router.react(to: .movieTapped, from: self, info: id)
            }
        }
    }
}


//Mark:- Call Services
extension SearchMoviesViewController  {
    func getMoviesSearch(moviesName: String, page: String) {
        viewModel.searchMovies(name: moviesName, language: "pt-Br", page: page )
            .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                self.collectionView.reloadData()
            }, onError: { (error) in
                self.showAlert(for: error)
            }, onCompleted: {
            }, onDisposed: {
               
            }).disposed(by: disposeBag)
    }
}

//MARK:- UISearchBar Delegates
extension SearchMoviesViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.movies = MoviesResponse()
        self.page = 1
        if searchText.count >= 3 {
            self.getMoviesSearch(moviesName: searchText, page: String(
                describing:self.page))
        }else {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Instantiation
extension SearchMoviesViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> SearchMoviesViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SearchMoviesViewController
    }
}
