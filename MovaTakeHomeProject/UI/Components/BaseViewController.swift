//
//  BaseViewController.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeForNotifications()
    }

    deinit {
        unsubscribeFromNotifications()
    }
    
    // MARK: - Notifications
    
    private func subscribeForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification),
            name:  UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHideNotification),
            name:  UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Keyboard handling
    
    func applyKeyboardAppearedWith(keyboardHeight: CGFloat) {}
    func applyKeyboardDisappeared() {}
    
    @objc private func keyboardNotification(_ notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let duration = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: animationCurve,
                animations: {
                    self.applyKeyboardAppearedWith(keyboardHeight: keyboardHeight)
                    self.view.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
    
    @objc private func keyboardHideNotification(_ notification: NSNotification) {
        let duration = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: animationCurve,
            animations: {
                self.applyKeyboardDisappeared()
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
    
}
