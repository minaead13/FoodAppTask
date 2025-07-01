//
//  OrderCardView.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import SwiftUI

struct OrderCardView: View {
    
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.blue)
                Text("Customer: \(order.customerName)")
                    .font(.headline)
            }
            
            HStack {
                Image(systemName: "fork.knife")
                    .foregroundColor(.green)
                Text("Restaurant: \(order.restaurant)")
                    .font(.subheadline)
            }
            
            HStack {
                Image(systemName: order.status.iconName)
                    .foregroundColor(.orange)
                Text("Status:")
                Text("\(order.status.rawValue)")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(order.status.color)
                    )
                    
            }
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    OrderCardView(order: Order(id: "order123", customerName: "Mina", restaurant: "Pizza", status: .ready))
}
