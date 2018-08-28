//
//  JSON.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 23/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

class JSON {
    class func serialize(dictionary: [String: Any]) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            return jsonData
        } catch {
            // Return nil if serialization fails
            return nil
        }
    }
    
    class func deserialize(data: Data) -> [String: Any]? {
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return jsonDict as? [String: Any]
        } catch {
            return nil
        }
    }
}
