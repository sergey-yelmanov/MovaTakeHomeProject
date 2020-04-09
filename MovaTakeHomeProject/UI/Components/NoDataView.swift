//
//  NoDataView.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

protocol NoDataViewDelegate: class {
    func actionButtonTapped()
}

final class NoDataView: UIView {

    // MARK: - UI Elements
    
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    private let actionButton = UIButton()
    
    // MARK: - Properties
    
    weak var delegate: NoDataViewDelegate?
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = .white
        setupTextLabel()
        setupImageView()
        setupActionButton()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setup(text: String, image: UIImage?) {
        textLabel.text = text
        imageView.image = image
        actionButton.isHidden = image == nil
    }
    
    private func setupTextLabel() {
        textLabel.textColor = Constants.Color.textColor
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
    
    private func setupActionButton() {
        let title = NSAttributedString(
            string: "Back to history",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: Constants.Color.linkColor,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        actionButton.setAttributedTitle(title, for: .normal)
        actionButton.backgroundColor = .clear
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Constants.ScreenInset.topSafeAreaInset),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -16),
            actionButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 32),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    // MARK: - Selectors
    
    @objc private func actionButtonTapped() {
        delegate?.actionButtonTapped()
    }
    
}
