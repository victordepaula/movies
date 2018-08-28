//
//  Extension+UIView.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

fileprivate let loadingViewIdentifier = 101010

extension UIView {
    func startLoading(_ shadow: Bool = true) {
        let loadingView = UIView()
        loadingView.frame = self.bounds
        loadingView.tag = loadingViewIdentifier
        
        let activityIndicator = LoadingConvenience.activityIndicator
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        
        if shadow {
            let shadowView = LoadingConvenience.shadowView
            shadowView.frame = self.bounds
            loadingView.addSubview(shadowView)
        }
        
        loadingView.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            self.addSubview(loadingView)
        }
    }

    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    
    func stopLoading() {
        let holderView = self.viewWithTag(loadingViewIdentifier)
        DispatchQueue.main.async {
            holderView?.removeFromSuperview()
        }
    }
    
    func stopLoadingWebView() {
        let holderView = self.viewWithTag(loadingViewIdentifier)
        DispatchQueue.main.async {
            holderView?.removeFromSuperview()
        }
    }
    
}

