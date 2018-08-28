//
//  AnotherMoviesTableViewCell.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AnotherMoviesTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView! {
        didSet {
            self.movieCollectionView.delegate = self
            self.movieCollectionView.dataSource = self
        }
    }
    
    //Mark:- Properties
    var moviesResponse: [Movies]? = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setup(movies: [Movies]?, title: String?) {
        if let movieReceived = movies, let titleReceived = title {
            self.moviesResponse = movieReceived
            self.titleLabel.text = titleReceived
            self.movieCollectionView.reloadData()
        }
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
    }
}


extension AnotherMoviesTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesResponse?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnotherMovieCollectionViewCell.identifier, for: indexPath) as? AnotherMovieCollectionViewCell {
            if moviesResponse?.count ?? 0 > 0 {
                if let movie = moviesResponse?[indexPath.row] {
                    cell.setupCel(movie: movie)
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = self.moviesResponse?[indexPath.row] {
            if let id = movie.id {
                if let viewController = self.viewController() as? MoviesViewController {
                    viewController.showDetailsScreen(movieId: id)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width-10)/3.4, height: collectionView.bounds.height)
    }
}

