//
//  AlertService.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

struct AlertService {

    static func showAlert(
        vc: UIViewController,
        title: String?,
        message: String? = nil,
        completionHandler:(()->())? = nil
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completionHandler?()
            }
            
            alert.addAction(okAction)
            
            vc.present(alert, animated: true)
        }
    }
    
}
