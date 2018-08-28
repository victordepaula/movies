//
//  MoviesDetailsResponse.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 26/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

struct MoviesDetailsResponse: Codable {
    var id: Int64?
    var adult: Bool?
    var backdrop_path: String?
    var genres: [Genre]?
    var homePage: String?
    var release_date: String?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int64?
    var poster_path: String?
    var overview: String?
}

struct Genre : Codable {
    var id: Int?
    var name: String?
}
