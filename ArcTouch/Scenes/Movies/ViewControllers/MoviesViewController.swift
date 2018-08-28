//
//  MoviesViewController.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController {
    //Mark:- IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    //Mark:- Propeties
    var disposeBag  = DisposeBag()
    var viewModel = MoviesViewModel()
    var i = 1
    let router = MoviesRouter()
    
    //Mark:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listUpCommingMovies()
        self.listGenreMovies()
    }
    
    
    //Mark:- Misc
    func callServicesByGenre() {
        if let genres = self.viewModel.genreResponse {
            if let genresResult = genres.genres {
                for item in genresResult {
                    if let id = item.id, let genre = item.name {
                        self.listGenreMovies(idGenre: String(describing:id), genre: genre)
                    }
                }
            }
        }
    }
    
    func showDetailsScreen(movieId: Int64) {
        router.react(to: .movieTapped, from: self, info: movieId)
    }
}

// MARK: - TableView Delegate, DataSource
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfGenres + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= self.viewModel.numberOfGenres {
            return 0
        }
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.identifier, for: indexPath) as? TopRatedTableViewCell {
                if let movies = self.viewModel.movies?.results {
                    cell.setup(movies: movies)
                }
                return cell
            }
        }else {
            if indexPath.row < self.viewModel.numberOfGenres {
                if let cell = tableView.dequeueReusableCell(withIdentifier: AnotherMoviesTableViewCell.identifier, for: indexPath) as? AnotherMoviesTableViewCell {
                    if  let dict = self.viewModel.listMoviesByGenreDict?.getElementByIndex(i: indexPath.row) {
                        cell.setup(movies: dict.value, title: dict.key)
                    }
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}

//Mark:- Call Apis
extension MoviesViewController  {
    func listGenreMovies() {
        self.view.startLoading()
        viewModel.listGenreMovies()
            .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                print(service)
                self.callServicesByGenre()
               
            }, onError: { (error) in
                self.showAlert(for: error)
            }, onCompleted: {
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
    
    
    func listGenreMovies(idGenre: String, genre: String) {
        viewModel.listMoviesByGenre(genreId: idGenre, genreName: genre)
            .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                if self.i == self.viewModel.numberOfGenres {
                    self.tableView.reloadData()
                }
                self.i = self.i + 1
            }, onError: { (error) in
                self.showAlert(for: error)
            }, onCompleted: {
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
    
    func listUpCommingMovies() {
        self.view.startLoading()
        viewModel.listUpCommingMovies()
            .observeOn(MainScheduler.instance).subscribe(onNext: { (service) in
                print(service)

            }, onError: { (error) in
                self.showAlert(for: error)
            }, onCompleted: {
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
}


// MARK: - Instantiation
extension MoviesViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> MoviesViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MoviesViewController
    }
}
