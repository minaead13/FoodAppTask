//
//  OrdersModel.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import SwiftUI


struct Order: Identifiable, Codable {
    let id: String
    let customerName, restaurant: String
    var status: Status
}

struct UpdateOrderStatusResponse: Codable {
    let order: Order
    let message: String
}

struct OrderUpdate: Codable {
    let orderId: String
    let status: String
}

enum Status: String, Codable, CaseIterable {
    case preparing = "preparing"
    case ready = "ready"
    case delivered = "delivered"
    case cancelled = "cancelled"
    case outForDelivery = "out-for-delivery"
}

extension Status {
    var displayName: String {
        switch self {
        case .cancelled:
            return "Cancelled"
        case .delivered:
            return "Delivered"
        case .outForDelivery:
            return "Out for Delivery"
        case .preparing:
            return "Preparing"
        case .ready:
            return "Ready"
        }
    }
    
    var color: Color {
        switch self {
        case .cancelled:
            return .red.opacity(0.2)
        case .delivered:
            return .green.opacity(0.2)
        case .outForDelivery:
            return .orange.opacity(0.2)
        case .preparing:
            return .yellow.opacity(0.2)
        case .ready:
            return .blue.opacity(0.2)
        }
    }
    
    var iconName: String {
        switch self {
        case .cancelled:
            return "xmark.circle.fill"
        case .delivered:
            return "checkmark.circle.fill"
        case .outForDelivery:
            return "car.fill"
        case .preparing:
            return "hourglass"
        case .ready:
            return "bell.fill"
        }
    }
}

