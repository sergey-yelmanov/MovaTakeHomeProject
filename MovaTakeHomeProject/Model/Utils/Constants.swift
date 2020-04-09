//
//  Constants.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

enum Constants {
    
    static let apiKey = "7_FVwTp9qm0ElcUxbWs41HwpxgwAAfFKB3VZRGywMKk"
    
    // MARK: - Colors
    
    enum Color {
        
        static let textColor = UIColor(white: 0.2, alpha: 1)
        static let linkColor = UIColor(red: 34/255, green: 0, blue: 204/255, alpha: 1)
        
    }
    
    // MARK: - Accessibility identifiers

    enum AccessibilityIdentifier {

        static let isLoading = "isLoading"

    }
    
    // MARK: - Screen insets
    
    enum ScreenInset {

        static var topSafeAreaInset: CGFloat {
            (UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 20) + 44
        }

        static var bottomSafeAreaInset: CGFloat {
            UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
        }

    }
    
}
