//
//  EndPoints.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import Foundation

struct Urls {
    static let BASE_API_URL: String = "http://localhost:8080"
    static let webSocketURL: String =  "ws://localhost:8080/orders/updates"
    
    private static let orders = "/orders"
    
    static var ordersURL : String {
        return BASE_API_URL + orders
    }
}
