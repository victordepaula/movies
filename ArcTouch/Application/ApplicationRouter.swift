//
//  ApplicationRouter.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 24/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

class ApplicationRouter {
    // MARK: - Enum
    fileprivate enum ApplicationStartPoint {
        case movies
        case mainTabBar
        
    }
    
    // MARK: - Properties
    fileprivate lazy var moviesStoryboard: UIStoryboard = UIStoryboard(name: "Movies", bundle: Bundle .main)
    fileprivate lazy var mainTabBarStoryboard: UIStoryboard = UIStoryboard(name: "MainTabBar", bundle: nil)
    
    // MARK: - Lifecycle
    func startApplication(in window: UIWindow?) {
        // TODO: define logic to decide startPoint
        guard let window = window else { return }
        self.startApplication(in: window, startPoint: .mainTabBar)
    }
    
    fileprivate func startApplication(in window: UIWindow, startPoint: ApplicationStartPoint) {
        switch startPoint {
        case .movies:
            let backAlwaysCampaignViewController = MoviesViewController.instantiate(fromStoryboard: moviesStoryboard)
            let rootNavigationController = UINavigationController(rootViewController: backAlwaysCampaignViewController)
            setRootNavigationController(rootNavigationController, for: window)
        case .mainTabBar:
            let mainTabBarViewController = MainTabBarController.instantiate(fromStoryboard: mainTabBarStoryboard)
            let rootNavigationController = UINavigationController(rootViewController: mainTabBarViewController)
            setRootNavigationController(rootNavigationController, for: window)
        }
    }
    
    fileprivate func setRootNavigationController(_ rootNavigationController: UINavigationController, for window: UIWindow) {
        window.rootViewController = rootNavigationController
        // Add animation?
        window.makeKeyAndVisible()
    }
}
