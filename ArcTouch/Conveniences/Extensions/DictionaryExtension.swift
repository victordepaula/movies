//
//  DictionaryExtension.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 27/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary where Value: Equatable {
    func getElementByIndex(i: Int) -> (key:Key,value:Value)  {
        return self[index(startIndex, offsetBy: i)]
    }
}
