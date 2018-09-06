//
//  UIViewControllerExtension.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 26/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // MARK: Alerts
    func showAlert(for error: Error) {
        guard let serviceError = error as? ServiceError, let alertText = serviceError.message else { return }
        let bottomAlertController = BottomAlertViewController.instantiateNew(withText: alertText, buttonTitle: "Ok", actionClosure: nil)
        self.present(bottomAlertController, animated: true, completion: nil)
    }
    
    func showAlertWithTimer(for error:Error) {
        guard let serviceError = error as? ServiceError, let alertText = serviceError.message else { return }
        let bottomAlertController = BottomAlertViewController.instantiateNew(withText: alertText, buttonTitle: "", actionClosure: nil)
        self.present(bottomAlertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
