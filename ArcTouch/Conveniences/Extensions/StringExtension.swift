//
//  StringExtension.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 23/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation

extension String {
    // MARK: - Localization
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func getUrlImage() -> String {
        return "https://image.tmdb.org/t/p/w1280/" + self
    }
}
