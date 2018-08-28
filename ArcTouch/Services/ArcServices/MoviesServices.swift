//
//  MoviesServices.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

class MoviesServices {
    // MARK: Get Url Strings
    func getBaseUrl() -> String {
        return URLInfo.url(fromKey: "baseUrl")
    }
    
    func getApiKey() -> String {
        return URLInfo.url(fromKey: "apiKey")
    }
    
    func getSearchMovies(movie: String, page: String, language: String) -> String {
        var url = URLInfo.url(fromKey: "movies")
        url = url.replacingOccurrences(of: "{api_key}", with: getApiKey())
        url = url.replacingOccurrences(of: "{page}", with: page)
        url = url.replacingOccurrences(of: "{query}", with: movie)
        url = url.replacingOccurrences(of: "{language}", with: language)
        if let urlWithSpaces = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            return getBaseUrl() + urlWithSpaces
        }
        return getBaseUrl() + url
    }
    
    func getBaseUrlDetails(idMovie: String) -> String {
        var url = URLInfo.url(fromKey: "idMovie")
        url = url.replacingOccurrences(of: "{idMovie}", with: idMovie)
        return getBaseUrl() + url
    }

    func getMovieByIdUrl(id: String, language: String) -> String {
        var url = URLInfo.url(fromKey: "movieById")
        url = url.replacingOccurrences(of: "{api_key}", with: getApiKey())
        url = url.replacingOccurrences(of: "{movie_id}", with: id)
        url = url.replacingOccurrences(of: "{language}", with: language)
        return getBaseUrl() + url
    }
    
    
    func getGenreMovies(language: String) -> String {
        var url = URLInfo.url(fromKey: "listGenre")
        url = url.replacingOccurrences(of: "{api_key}", with: getApiKey())
        url = url.replacingOccurrences(of: "{language}", with: language)
        return getBaseUrl() + url
    }
    
    func getMoviesByGenreUrl(genreId: String ,language: String) -> String {
        var url = URLInfo.url(fromKey: "movieByGenre")
        url = url.replacingOccurrences(of: "{api_key}", with: getApiKey())
        url = url.replacingOccurrences(of: "{language}", with: language)
        url = url.replacingOccurrences(of: "{genres_id}", with: genreId)
        return getBaseUrl() + url
    }
    
   

    func getVideoByMovie(id: String, language: String) -> String {
        var url = URLInfo.url(fromKey: "movieView")
        url = url.replacingOccurrences(of: "{api_key}", with: getApiKey())
        url = url.replacingOccurrences(of: "{movie_id}", with: id)
        url = url.replacingOccurrences(of: "{language}", with: language)
        return getBaseUrl() + url
    }

    
    func getRecomendedUrl(page:String, language: String) -> String {
        var url = URLInfo.url(fromKey: "moviesRecomended")
        url = url.replacingOccurrences(of: "{api_key}", with: getApiKey())
        url = url.replacingOccurrences(of: "{language}", with: language)
        url = url.replacingOccurrences(of: "{page}", with: page)
        return getBaseUrl() + url
    }
    
    
    func getUpCommingMoviesUrl(page: String, language: String) -> String {
        var url = URLInfo.url(fromKey: "upComingMovies")
        url = url.replacingOccurrences(of: "{api_key}", with: getApiKey())
        url = url.replacingOccurrences(of: "{language}", with: language)
        url = url.replacingOccurrences(of: "{page}", with: page)
        url = url.replacingOccurrences(of: "\n", with: "")
        return getBaseUrl() + url
    }
    

    // MARK: API Calls
    func getRecomendedMovies(page: String, language: String, success: @escaping (( _  movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getRecomendedUrl(page: page, language: language)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil , auth: true).response(succeed: { (_ movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) in
                if  let content = serviceResponse, let response = movieResponse {
                    success(response,content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
    
    func getMovieById(id: String, language: String,success: @escaping (( _  movieResponse: MoviesDetailsResponse? , _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getMovieByIdUrl(id: id, language: language)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil , auth: true).response(succeed: { (_ movieResponse: MoviesDetailsResponse? , _ serviceResponse: ServiceResponse?) in
                if  let content = serviceResponse, let response = movieResponse {
                    success(response,content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    

    func getVideoByMovie(id: String, language: String,success: @escaping (( _  movieResponse: VideoResponse? , _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getVideoByMovie(id: id, language: language)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil , auth: true).response(succeed: { (_ movieResponse: VideoResponse? , _ serviceResponse: ServiceResponse?) in
                if  let content = serviceResponse, let response = movieResponse {
                    success(response,content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
    func getMoviesByGenre(id: String, language: String,success: @escaping (( _  movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getMoviesByGenreUrl(genreId: id, language: language)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil , auth: true).response(succeed: { (_ movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) in
                if  let content = serviceResponse, let response = movieResponse {
                    success(response,content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
    
    
    func getUpCommingMovies(page: String, language: String,success: @escaping (( _  movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getUpCommingMoviesUrl(page: page, language: language)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil , auth: true).response(succeed: { (_ movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) in
                if  let content = serviceResponse, let response = movieResponse {
                    success(response,content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
    func searchMovies(name: String ,language: String, page: String,  success: @escaping (( _  movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getSearchMovies(movie: name, page: page, language: language)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil , auth: true).response(succeed: { (_ movieResponse: MoviesResponse? , _ serviceResponse: ServiceResponse?) in
                if  let content = serviceResponse, let response = movieResponse {
                    success(response,content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
    
    
    func listGenreMovies(language: String,  success: @escaping (( _  movieResponse: GenrerResponse? , _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getGenreMovies(language: language)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil , auth: true).response(succeed: { (_ movieResponse: GenrerResponse? , _ serviceResponse: ServiceResponse?) in
                if  let content = serviceResponse, let response = movieResponse {
                    success(response,content)
                }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
}
