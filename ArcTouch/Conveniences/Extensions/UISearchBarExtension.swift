//
//  UISearchBarExtension.swift
//  ArcTouch
//
//  Created by victor on 27/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {

    private var textField: UITextField? {
        return subviews.first?.subviews.compactMap { $0 as? UITextField }.first
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        return textField?.rightView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }
    
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = UIColor.clear
                    textField?.rightView?.addSubview(newActivityIndicator)
                    let rightViewSize = textField?.rightView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: rightViewSize.width/2, y: rightViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
