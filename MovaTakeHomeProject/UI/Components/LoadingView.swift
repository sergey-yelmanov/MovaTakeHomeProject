//
//  LoadingView.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class LoadingView: UIView {

    init(view: UIView) {
        super.init(frame: view.frame)
        
        accessibilityIdentifier = Constants.AccessibilityIdentifier.isLoading
        backgroundColor = .clear
        
        let dimmedView = setupDimmedView()
        
        view.addSubview(dimmedView)
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.heightAnchor.constraint(equalToConstant: 75),
            dimmedView.widthAnchor.constraint(equalToConstant: 75),
            dimmedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dimmedView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        dimmedView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: dimmedView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: dimmedView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.1) {
            dimmedView.alpha = 1.0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDimmedView() -> UIView {
        let dimmedView = UIView()
        dimmedView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        dimmedView.alpha = 0
        dimmedView.layer.cornerRadius = 8
        

        return dimmedView
    }

}

