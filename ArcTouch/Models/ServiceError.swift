//
//  ServiceError.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 23/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

struct ServiceError: Codable, Error {
    // MARK: - Properties
    var code: String?
    var title: String?
    var detail: String?
    
    var statusCode: Int? // This is coming from the service
    var error: String? // This is coming from the service
    var message: String? // This is coming from the service
}
