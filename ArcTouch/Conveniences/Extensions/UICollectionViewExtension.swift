//
//  UICollectionViewExtension.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 26/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func lastIndexPath() -> IndexPath? {
        for sectionIndex in (0..<self.numberOfSections).reversed() {
            if self.numberOfItems(inSection: sectionIndex) > 0 {
                return IndexPath.init(item: self.numberOfItems(inSection: sectionIndex)-1, section: sectionIndex)
            }
        }
        
        return nil
    }
}
