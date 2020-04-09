//
//  Router.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class Router {

    // MARK: - Singleton
    
    static var shared: Router!
    
    // MARK: - Properties
    
    private var window: UIWindow!
    private var targetView: UIView?
    
    // MARK: - Initializers

    init(_ sceneWindow: UIWindow) {
        window = sceneWindow
        Router.shared = self
    }

    // MARK: - Start up logic
    
    func showStartUpScreen() {
        window.rootViewController = UINavigationController(rootViewController: PhotoListVC())
        window.makeKeyAndVisible()
    }
    
    // MARK: - Loading helpers
    
    func showLoading(in view: UIView) {
        dismissLoading()

        targetView = view
        guard let targetView = targetView else { return }

        let loadingView = LoadingView()

        DispatchQueue.main.async {
            targetView.addSubview(loadingView)
        }
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
