//
//  LoadingView.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    // MARK: - UI Elements
    
    private let dimmedView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Initializers
    
    init(view: UIView) {
        super.init(frame: view.frame)
        
        accessibilityIdentifier = Constants.AccessibilityIdentifier.isLoading
        backgroundColor = .clear
        
        setupDimmedView()
        setupActivityIndicator()
        setupConstraints()
        
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.1) {
            self.dimmedView.alpha = 1
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    private func setupDimmedView() {
        dimmedView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        dimmedView.layer.cornerRadius = 8
        dimmedView.alpha = 0
        
        addSubview(dimmedView)
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .white
        dimmedView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dimmedView.heightAnchor.constraint(equalToConstant: 75),
            dimmedView.widthAnchor.constraint(equalToConstant: 75),
            dimmedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dimmedView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Constants.ScreenInset.topSafeAreaInset),
            activityIndicator.centerXAnchor.constraint(equalTo: dimmedView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: dimmedView.centerYAnchor)
        ])
    }
    
}

