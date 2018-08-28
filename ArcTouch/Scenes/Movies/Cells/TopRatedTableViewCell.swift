//
//  TopRatedTableViewCell.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {
    //MARKL- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
     @IBOutlet weak var collectionViewLayout: UPCarouselFlowLayout!
    
    //Mark:- Properties
    var moviesResponse: [Movies]? = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCollectionView()
    }
    
    func setup(movies: [Movies]?) {
        if let moviesReceived = movies {
            self.moviesResponse = moviesReceived
            self.collectionView.reloadData()
        }
    }
    
    func configureCollectionView(){
        collectionViewLayout?.sideItemScale = 0.85
        collectionViewLayout?.sideItemAlpha = 0.8
        collectionViewLayout?.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: -40)
    }
}

extension TopRatedTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesResponse?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCollectionViewCell.identifier, for: indexPath) as? TopRatedCollectionViewCell {
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
            let width = collectionView.bounds.width
            return CGSize(width: width, height: collectionView.bounds.height)
    }
}
