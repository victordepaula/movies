//
//  ServiceResponse.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 23/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

struct ServiceResponse {
    var data: Data?
    var rawResponse: String?
    var response: HTTPURLResponse?
    var request: URLRequest?
    var serviceError: ServiceError?
}
