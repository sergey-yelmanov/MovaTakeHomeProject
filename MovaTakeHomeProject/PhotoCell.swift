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
        
        setupPhotoImageView()
        setupKeywordLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    
    func setup() {}
    
    private func setupPhotoImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.image = UIImage(named: "1")
        photoImageView.layer.cornerRadius = 16
        photoImageView.layer.masksToBounds = true
        photoImageView.clipsToBounds = true
        
        addSubview(photoImageView)
        
        photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupKeywordLabel() {
        keywordLabel.text = "texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext"
        keywordLabel.textColor = .white
        keywordLabel.font = .boldSystemFont(ofSize: 16)
        keywordLabel.textAlignment = .left
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.addSubview(keywordLabel)
        
        keywordLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -16).isActive = true
        keywordLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -16).isActive = true
        keywordLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 16).isActive = true
    }
    
}
