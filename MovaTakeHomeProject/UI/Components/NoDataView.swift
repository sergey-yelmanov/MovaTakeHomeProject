//
//  NoDataView.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class NoDataView: UIView {

    private let imageView = UIImageView()
    private let textLabel = UILabel()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = .white
        setupTextLabel()
        setupImageView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(text: String, image: UIImage?) {
        textLabel.text = text
        imageView.image = image
    }
    
    private func setupTextLabel() {
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.font = .boldSystemFont(ofSize: 16)
        
        addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(white: 0.9, alpha: 1)
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Constants.ScreenInsets.topSafeAreaInset),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }
    
}
