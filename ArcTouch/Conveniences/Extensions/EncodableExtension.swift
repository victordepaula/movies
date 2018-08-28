//
//  EncodableExtension.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 23/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionaryValue: Dictionary<String, Any>? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return jsonDictionary as? [String: Any]
        } catch {
            return nil
        }
    }
    
    var listValues: Data? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        return data
    }
    
}
