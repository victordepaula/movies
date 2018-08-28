//
//  AnotherMovieCollectionViewCell.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import UIKit
import SDWebImage


class AnotherMovieCollectionViewCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func prepareForReuse() {
        self.movieImageView.image = nil
    }

    
    func setupCel(movie: Movies) {
        if let image = movie.poster_path {
            let avatar = image.getUrlImage()
            if let url = URL(string: avatar) {
                self.movieImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
    }
}
