//
//  MoviesResponse.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 23/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
    var page : Int?
    var total_results: Int?
    var total_pages : Int?
    var results: [Movies]?
}

struct Movies:Codable, Equatable {
    var vote_count:Int64?
    var id:Int64?
    var video: Bool?
    var vote_average: Float?
    var title:String?
    var popularity: Float?
    var poster_path: String?
    var original_language:String?
    var original_title: String?
    var genre_ids:[Int]?
    var backdrop_path: String?
    var adult:Bool?
    var overview: String?
    var release_date: String?
    var dictionary: [String : String]? = [String :  String]()
}
