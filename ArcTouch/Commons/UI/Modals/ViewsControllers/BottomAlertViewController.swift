//
//  BottomAlertViewController.swift
//  ArcTouch
//
//  Created by Victor de Paula Fernandes Pereira on 26/08/2018.
//  Copyright © 2018 Victor de Paula Fernandes Pereira. All rights reserved.
//

import UIKit

class BottomAlertViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var leftButton: UIButton!
    @IBOutlet weak private var rightButton: UIButton!
    
    // MARK: - Properties
    var text: String?
    var leftButtonTitle: String?
    private var leftButtonActionClosure: (()->())?
    var rightButtonTitle: String?
    private var rightButtonActionClosure: (()->())?
    
    // MARK: Instantiation
    static func instantiateNew(withText text: String!, leftButtonTitle: String? = nil, leftButtonActionClosure: (()->())? = nil, rightButtonTitle: String? = nil, rightButtonActionClosure: (()->())? = nil) -> BottomAlertViewController {
        
        // Storyboard
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! BottomAlertViewController
        
        // TextLabel
        controller.text = text
        
        // Left Button
        controller.leftButtonTitle = leftButtonTitle
        controller.leftButtonActionClosure = leftButtonActionClosure
        
        // Right Button
        controller.rightButtonTitle = rightButtonTitle
        controller.leftButtonActionClosure = leftButtonActionClosure
        
        // Safety Checks...
        if leftButtonTitle == nil && rightButtonTitle == nil {
            fatalError("You need at least one button apearing! Configure right or left, prefferably with an action!")
        }
        
        return controller
    }
    
    static func instantiateNew(withText text: String!, buttonTitle: String? = "Ok", actionClosure: (()->())? = nil) -> BottomAlertViewController {
        return BottomAlertViewController.instantiateNew(withText: text, leftButtonTitle: buttonTitle, leftButtonActionClosure: actionClosure, rightButtonTitle: nil, rightButtonActionClosure: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leftButton.isHidden = leftButtonTitle == nil
        rightButton.isHidden = rightButtonTitle == nil
    }
    
    // MARK: UI Configuration
    func setupUI(){
        textLabel.text = text
        leftButton.setTitle(leftButtonTitle, for: .normal)
        rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    // MARK: IBActions
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.leftButtonActionClosure?()
        }
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.rightButtonActionClosure?()
        }
    }
}

