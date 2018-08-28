//
//  MainTabBarController.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 25/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import  UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension MainTabBarController {
    // MARK: - Instantiation
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> MainTabBarController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MainTabBarController
    }
}
