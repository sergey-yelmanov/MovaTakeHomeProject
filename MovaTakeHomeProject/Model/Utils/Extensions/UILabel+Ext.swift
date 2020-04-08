//
//  UILabel+Ext.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UILabel {
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2, height: 4)
    }
    
}
