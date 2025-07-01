//
//  NetworkManager.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import Foundation
import Alamofire
import UIKit

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse(Int)
    case decodingFailed(Error)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Codable>(
        urlString: String,
        type: T.Type,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        AF.request(url, method: method, parameters: parameters, headers: getHeaders())
            .validate()
            .responseDecodable(of: T.self, decoder: decoder) { response in
                
                switch response.result {
                case .success(let decoded):
                    completion(.success(decoded))
                    
                case .failure(let error):
                    
                    if let statusCode = response.response?.statusCode, !(200..<300).contains(statusCode) {
                        completion(.failure(.invalidResponse(statusCode)))
                    } else if let afError = error.asAFError {
                        completion(.failure(.requestFailed(afError)))
                    } else {
                        completion(.failure(.decodingFailed(error)))
                    }
                }
            }
    }
    
    
    func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Accept-Language" : "en"
        ]
        return headers
    }
}
