//
//  ViewModel.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var orderDetails: Order?
    @Published var selectedStatus: Status = .ready
    @Published var isUpdatingStatus: Bool = false
    
    init() {
        connectWebSocket()
    }
    
    func connectWebSocket() {
        WebSocketManager.shared.onOrderUpdate = { [weak self] update in
            DispatchQueue.main.async {
                self?.updateOrderStatus(orderId: update.orderId, newStatus: update.status)
            }
        }
        WebSocketManager.shared.connect()
    }
    
    private func updateOrderStatus(orderId: String, newStatus: String) {
        if let index = orders.firstIndex(where: { $0.id == orderId }) {
            let status = Status(rawValue: newStatus) ?? .preparing
            self.orders[index].status = status
            self.selectedStatus = status
        } else {
            print("Order not found in list for update")
        }
    }
    
    deinit {
        WebSocketManager.shared.disconnect()
    }
    
    func getOrders() {
        NetworkManager.shared.request(
            urlString: Urls.ordersURL,
            type: [Order].self,
            decoder: JSONDecoder()
        ) { result in
            
            switch result {
            case .success(let orders):
                self.orders = orders
                
            case .failure(let error):
                print("error is \(error.localizedDescription)")
            }
        }
    }
    
    func getOrderDetails(id: String) {
        NetworkManager.shared.request(
            urlString: Urls.ordersURL + "/\(id)",
            type: Order.self,
            decoder: JSONDecoder()
        ) { result in
            
            switch result {
            case .success(let order):
                self.orderDetails = order
                self.selectedStatus = order.status
            case .failure(let error):
                print("error is \(error.localizedDescription)")
            }
        }
    }
    
    func updateOrderStatus(id: String, newStatus: String) {
        isUpdatingStatus = true
        NetworkManager.shared.request(
            urlString: Urls.ordersURL + "/\(id)/status",
            type: UpdateOrderStatusResponse.self,
            method: .patch,
            parameters: ["status": newStatus],
            decoder: JSONDecoder()
        ) { result in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isUpdatingStatus = false
                
                switch result {
                case .success(let response):
                    self.orderDetails = response.order
                case .failure(let error):
                    print("Error updating status: \(error)")
                }
            }
        }
    }
}
