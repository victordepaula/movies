//
//  MoviesRouter.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

enum MoviesRouterEvent {
    case movieTapped
}

class MoviesRouter {
    // MARK: - Segue
    enum MoviesSegue {
        case movie
    }
    
    // MARK: - Properties
    fileprivate lazy var moviesDetails = UIStoryboard(name: "DetailsMovies", bundle: nil)
   
    func react(to event: MoviesRouterEvent, from source: UIViewController, info: Any?) {
        switch event {
        case .movieTapped:
            showDetails(from: source, with: info)
        }
    }
    
    private func showDetails(from source: UIViewController, with info: Any?)  {
        let detailsMovies = DetailsViewController.instantiate(fromStoryboard: moviesDetails)
        if let movieConverted = info as? Int64 {
            detailsMovies.movieId = movieConverted
        }
        perform(.movie, from: source, to: detailsMovies)
    }
}

private extension MoviesRouter {
    func perform(_ segue: MoviesSegue, from source: UIViewController, to controller: UIViewController) {
        switch segue {
        case .movie:
            source.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
