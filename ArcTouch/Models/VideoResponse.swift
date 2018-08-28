//
//  VideoResponse.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 27/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

struct VideoResponse : Codable {
    var id : Int64?
    var results: [Video]?
}

struct Video :  Codable {
    var id: String?
    var iso_639_1: String?
    var iso_3166_1: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Float?
    var type: String?
}
