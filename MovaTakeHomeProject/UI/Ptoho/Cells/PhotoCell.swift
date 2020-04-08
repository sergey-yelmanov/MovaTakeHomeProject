//
//  PhotoCell.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

final class PhotoCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let photoImageView = UIImageView()
    private let keywordLabel = UILabel()

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupKeywordLabel()
        setupPhotoImageView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        photoImageView.image = nil
        keywordLabel.text = nil
    }
    
    // MARK: - Setup
    
    func setup(photo: Photo) {
        photoImageView.loadImage(fromURL: photo.urls.regular)
        keywordLabel.text = photo.keyword
    }
    
    private func setupKeywordLabel() {
        keywordLabel.textColor = .black
        keywordLabel.font = .boldSystemFont(ofSize: 18)
        keywordLabel.textAlignment = .left
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(keywordLabel)
    }
    
    private func setupPhotoImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 8
        photoImageView.layer.masksToBounds = true
        photoImageView.clipsToBounds = true
        
        addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            keywordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            keywordLabel.bottomAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -8),
            keywordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            keywordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
}

