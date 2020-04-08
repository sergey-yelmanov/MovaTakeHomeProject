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
    
    /// Method for fetching and parsing response from API.
    private func fetchData<T: Decodable>(with request: URLRequest, completionHandler: @escaping (Result<T, PhotoNetworkingError>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.invalidResponse))
            }
            
        }.resume()
    }
    
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
    
    func getRandomPhoto(withKeyword keyword: String, completionHandler: @escaping (Result<Photo, PhotoNetworkingError>) -> Void) {
        guard let urlRequest = getRequest(from: keyword) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        fetchData(with: urlRequest) { (response: Result<PhotoResponse, PhotoNetworkingError>) in
            switch response {
            case .success(let response):
                guard let randomPhoto = response.results.randomElement() else {
                    completionHandler(.failure(.noData))
                    return
                }
                
                randomPhoto.keyword = keyword
                completionHandler(.success(randomPhoto))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
