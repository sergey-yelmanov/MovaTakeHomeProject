//
//  PhotoService.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

final class PhotoService {
    
    static let shared = PhotoService()
    
    private let baseUrlString = "https://api.unsplash.com/"
    
    private init() {}
    
    func getRandomPhoto(withKeyword keyword: String, completionHandler: @escaping (Result<Photo, PhotoNetworkingError>) -> Void) {
        let originalString = baseUrlString + "search/photos?query=\(keyword)"
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Client-ID " + Constants.apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if error != nil {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(PhotoResponse.self, from: data)
                guard let randomPhoto = result.results.randomElement() else {
                    completionHandler(.failure(.noData))
                    return
                }
                
                randomPhoto.keyword = keyword
                completionHandler(.success(randomPhoto))
            } catch {
                completionHandler(.failure(.invalidResponse))
            }
            
        }.resume()
    }
    
}
