//
//  UICollectionViewCellExtensions.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
