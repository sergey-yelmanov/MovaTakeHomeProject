//
//  Router.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class Router {

    // MARK: - Properties
    
    static var shared: Router!
    
    private var window: UIWindow!
    private var targetView: UIView?
    
    // MARK: - Initializers

    init(_ sceneWindow: UIWindow) {
        window = sceneWindow
        Router.shared = self
    }

    func showStartUpScreen() {
        window.rootViewController = UINavigationController(rootViewController: PhotoListVC())
        window.makeKeyAndVisible()
    }
    
    func showLoading(in view: UIView? = nil) {
        dismissLoading()

        targetView = view ?? window.rootViewController?.view
        guard let targetView = targetView else { return }

        let loadingView = LoadingView(view: targetView)

        targetView.addSubview(loadingView)
    }
    
    func dismissLoading() {
        guard let targetView = targetView else { return }
        
        DispatchQueue.main.async {
            for subview in targetView.subviews where subview.accessibilityIdentifier == Constants.AccessibilityIdentifier.isLoading {
                UIView.animate(withDuration: 0.1, animations: {
                    subview.alpha = 0
                }) { _ in
                    subview.removeFromSuperview()
                }
            }
        }
    }

}
