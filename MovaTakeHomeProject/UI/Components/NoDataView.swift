//
//  NoDataView.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class NoDataView: UIView {

    private let containerView = UIView()
    private let textLabel = UILabel()
    
    init(text: String) {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = .white
        
        setupContainerView()
        setupTextLabel(with: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainerView() {
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 16
        
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setupTextLabel(with text: String) {
        textLabel.text = text
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = .boldSystemFont(ofSize: 16)
        
        containerView.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
    }
    
}
