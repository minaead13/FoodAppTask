//
//  OrderDetailsView.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import SwiftUI

struct OrderDetailsView: View {
    
    @ObservedObject var viewModel: ViewModel
    let orderId: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            if let orderDetails = viewModel.orderDetails {
                Text("Customer: \(orderDetails.customerName)")
                    .font(.title2)
                Text("Restaurant: \(orderDetails.restaurant)")
                Text("Status: \(orderDetails.status.rawValue)")
                    .padding(.bottom)
            }
            
            Picker("Update Status", selection: $viewModel.selectedStatus) {
                ForEach(Status.allCases, id: \.self) { status in
                    Text(status.displayName).tag(status)
                }
            }
            .pickerStyle(.segmented)
            
            Button {
                viewModel.updateOrderStatus(id: orderId, newStatus: viewModel.selectedStatus.rawValue)
            } label: {
                if viewModel.isUpdatingStatus {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(12)
                } else {
                    Text("Confirm Status Update")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    
                }
            }
            .disabled(viewModel.isUpdatingStatus)
            
            Spacer()
        }
        .task {
            viewModel.getOrderDetails(id: orderId)
        }
        .padding()
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    OrderDetailsView(viewModel: ViewModel(), orderId: "2")
}
