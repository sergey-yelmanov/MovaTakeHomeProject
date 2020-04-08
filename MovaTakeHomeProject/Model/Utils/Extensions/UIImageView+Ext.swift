//
//  UIImageView+Ext.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func loadImage(fromURL url: String) {
        image = UIImage(named: "placeholder")
        
        guard let imageURL = URL(string: url) else { return }
        
        let session = URLSession.shared
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                session.dataTask(with: request) { (data, response, error) in
                    if
                        let data = data,
                        let response = response,
                        error == nil,
                        ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                        let image = UIImage(data: data)
                    {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }.resume()
            }
        }
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(
            with: self, duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: {
                self.image = image
        },
            completion: nil)
    }
    
}
