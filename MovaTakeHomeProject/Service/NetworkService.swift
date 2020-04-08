//
//  NetworkService.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 08.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation
import Network

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let monitor = NWPathMonitor()
    private var internetAvailable = true
    
    private init() {
        setupNetworkMonitor()
    }
    
    // MARK: - Network monitor configuration

    private func setupNetworkMonitor() {
        let queue = DispatchQueue(label: "NetworkMonitor")
        
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.internetAvailable = path.status == .satisfied
        }

        monitor.start(queue: queue)
    }
    
    /// Method for fetching and parsing response from API.
    func fetchData<T: Decodable>(with request: URLRequest, completionHandler: @escaping (Result<T, NetworkingError>) -> Void) {
        if !internetAvailable {
            completionHandler(.failure(.noInternet))
            return
        }
        
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
    
}
