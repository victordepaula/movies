//
//  MoviesViewModel.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import RxSwift

class MoviesViewModel {
    
    // MARK: - Properties
    let service = MoviesServices()
    var movies : MoviesResponse?
    var moviesDetails : MoviesDetailsResponse?
    var videosResponse: VideoResponse?
    var genreResponse: GenrerResponse?
    var listMoviesByGenreDict : [String: [Movies]]? = [:]
    
    var language: String?  = Locale.current.languageCode
    
    var numberOfMovies: Int {
        return movies?.results?.count ?? 0
    }
    
    var numberOfGenres: Int {
        return genreResponse?.genres?.count ?? 0
    }
    
    var numberOfTrailers: Int {
        return videosResponse?.results?.count ?? 0
    }
    
    // MARK: Helpers
    func movieForIndexPath(for indexPath: IndexPath) -> Movies? {
        return movies?.results?[indexPath.row]
    }
    
    //Mark:- Call Services Api
    func searchMovies(name: String, language: String, page: String)  -> Observable<ServiceResponse> {
        return Observable.create { observable in
            self.service.searchMovies(name: name, language: language, page: page, success: { (moviesResponse, serviceResponse) in
                if let movies = moviesResponse, let service = serviceResponse {
                    print(service)
                    if let listMovies = movies.results {
                        if self.movies?.results == nil {
                            self.movies?.results = []
                        }
                        self.movies?.results?.append(contentsOf: listMovies)
                    }
                    self.movies?.total_results = movies.total_results
                    self.movies?.total_pages = movies.total_pages
                    observable.onNext(service)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }

    func listGenreMovies()  -> Observable<ServiceResponse> {
        return Observable.create { observable in
            self.service.listGenreMovies(language: self.language ?? "",  success: { (moviesResponse, serviceResponse) in
                if let movies = moviesResponse, let service = serviceResponse {
                    print(service)
                    self.genreResponse = movies
                    observable.onNext(service)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    
    func listMoviesByGenre(genreId: String, genreName: String)  -> Observable<ServiceResponse> {
        return Observable.create { observable in
            self.service.getMoviesByGenre(id: genreId, language: self.language ?? "",  success: { (moviesResponse, serviceResponse) in
                if let genreMovies = moviesResponse, let service = serviceResponse {
                    print(service)
                    if let results =  genreMovies.results {
                        self.listMoviesByGenreDict?[genreName] = results
                    }
                    observable.onNext(service)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    
    func listRecomendMovies(page: String)  -> Observable<ServiceResponse> {
        return Observable.create { observable in
            self.service.getRecomendedMovies(page:page , language: self.language ?? "", success: { (moviesResponse, serviceResponse) in
                if let movies = moviesResponse, let service = serviceResponse {
                    print(service)
                    self.movies = movies
                    observable.onNext(service)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    
    func listUpCommingMovies()  -> Observable<ServiceResponse> {
        return Observable.create { observable in
            self.service.getUpCommingMovies(page: "1", language: self.language ?? "", success: { (moviesResponse, serviceResponse) in
                if let movies = moviesResponse, let service = serviceResponse {
                    print(service)
                    self.movies = movies
                    observable.onNext(service)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    
    func getMovieById(moviesId: String)  -> Observable<ServiceResponse> {
        return Observable.create { observable in
            self.service.getMovieById(id: moviesId, language: self.language ?? "",  success: { (moviesResponse, serviceResponse) in
                if let movies = moviesResponse, let service = serviceResponse {
                    print(service)
                    self.moviesDetails = movies
                    observable.onNext(service)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getVideoByMovie(moviesId: String)  -> Observable<ServiceResponse> {
        return Observable.create { observable in
            self.service.getVideoByMovie(id: moviesId, language: self.language ?? "",  success: { (moviesResponse, serviceResponse) in
                if let movies = moviesResponse, let service = serviceResponse {
                    print(service)
                    self.videosResponse = movies
                    observable.onNext(service)
                }
            }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
}
