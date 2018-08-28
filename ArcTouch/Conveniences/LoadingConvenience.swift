//
//  LoadingConvenience.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

class LoadingConvenience {
    
    static let shared = LoadingConvenience()
    
    private var loadingView: UIView!
    private var window = (UIApplication.shared.delegate as! AppDelegate).window!
    
    static var blurView: UIVisualEffectView {
        
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = 0.85
        
        return view
    }
    
    static var shadowView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.55
        return view
    }
    
    static var activityIndicator: UIActivityIndicatorView {
        let loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//        loading.color = UIColor.greenDefault //ThemeManager.theme.accentColor.value
        return loading
    }
    
    // MARK: - Life Cycle
    
    init() {
        setupLoadingView()
    }
    
    // MARK: - Misc
    
    func enableFullScreenLoading() {
        window.addSubview(loadingView)
    }
    
    func disableFullScreenLoading() {
        loadingView.removeFromSuperview()
    }
    
    private func setupLoadingView() {
        loadingView = UIView(frame: window.bounds)
        loadingView.startLoading()
    }
}

