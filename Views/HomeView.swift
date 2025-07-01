//
//  HomeView.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 16) {
                    ForEach(viewModel.orders) { order in
                        NavigationLink(destination: OrderDetailsView(viewModel: viewModel, orderId: order.id)) {
                            OrderCardView(order: order)
                        }
                        .buttonStyle(.plain)
                       
                    }
                }
                .padding()
                .task {
                    viewModel.getOrders()
                }
                .navigationTitle("Orders")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    HomeView()
}
