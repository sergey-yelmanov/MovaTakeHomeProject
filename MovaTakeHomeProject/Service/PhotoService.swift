//
//  PhotoService.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

final class PhotoService {
    
    private let baseUrlString = "https://api.unsplash.com/"
    
    init() {}
    
    /// Method for building request from search keyword
    private func getRequest(from keyword: String) -> URLRequest? {
        let originalString = baseUrlString + "search/photos?query=\(keyword)"
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID " + Constants.apiKey, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getRandomPhoto(withKeyword keyword: String, completionHandler: @escaping (Result<Photo?, NetworkingError>) -> Void) {
        guard let urlRequest = getRequest(from: keyword) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        NetworkService.shared.fetchData(with: urlRequest) { (response: Result<PhotoResponse, NetworkingError>) in
            switch response {
            case .success(let response):
                let randomPhoto = response.results.randomElement()
                randomPhoto?.keyword = keyword
                completionHandler(.success(randomPhoto))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
