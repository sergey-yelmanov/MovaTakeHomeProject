//
//  NetworkingError.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

enum PhotoNetworkingError: String, Error {
    
    case invalidUrl = "Invalid URL"
    case invalidRequest = "Invalid request"
    case invalidResponse = "Invalid response"
    case noData = "No photo found for the specified word"
    
}

extension PhotoNetworkingError: LocalizedError {
    
    var errorDescription: String? {
        NSLocalizedString(rawValue, comment: "")
    }
    
}
