//
//  NetworkManager.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 26.12.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://fakestoreapi.com/products"
    
    private init() {}
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
