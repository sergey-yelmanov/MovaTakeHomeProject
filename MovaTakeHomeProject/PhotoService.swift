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
    
    
    func getRandomPhoto(withKeyword keyword: String, completionHandler: @escaping (Result<Photo, Error>) -> Void) {
        let url = URL(string: baseUrlString + "search/photos?query=\(keyword)")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Client-ID " + Constants.apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PhotoResponse.self, from: data)
                    if let randomPhoto = result.results.randomElement() {
                        randomPhoto.keyword = keyword
                        completionHandler(.success(randomPhoto))
                    }
                } catch {
                    completionHandler(.failure(error))
                }
                
                return
            }
        }.resume()
    }
    
}
