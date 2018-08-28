//
//  URLInfo.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

public class URLInfo: NSObject {
    static func url(fromKey key: String) -> String {
        guard
            let path = Bundle.main.path(forResource: "URLs", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String]
            else {
                return ""
        }
        if let url = dict[key] {
            return (url)
        } else {
            return ""
        }
        
    }
}
