//
//  WebSocketManager.swift
//  FoodAppTask
//
//  Created by OSX on 01/07/2025.
//

import Foundation

class WebSocketManager {
    
    static let shared = WebSocketManager()
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let urlSession = URLSession(configuration: .default)
    
    var onOrderUpdate: ((OrderUpdate) -> Void)?
    
    func connect() {
        guard let url = URL(string: Urls.webSocketURL) else {
            return
        }
        
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        
        listen()
    }
    
    private func listen() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("WebSocket error: \(error)")
                
            case .success(let message):
                switch message {
                case .string(let text):
                    if let data = text.data(using: .utf8),
                       let update = try? JSONDecoder().decode(OrderUpdate.self, from: data) {
                        self?.onOrderUpdate?(update)
                    }
                    
                case .data(let data):
                    if let update = try? JSONDecoder().decode(OrderUpdate.self, from: data) {
                        self?.onOrderUpdate?(update)
                    }
                    
                @unknown default:
                    print("Unknown message")
                }
                
                
                self?.listen()
            }
        }
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}
