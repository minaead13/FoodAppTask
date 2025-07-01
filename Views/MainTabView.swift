//
//  MainTabView.swift
//  FoodAppTask
//
//  Created by OSX on 30/06/2025.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .onAppear{ selectedTab = 0 }
                .tag(0)
        }
    }
}

#Preview {
    MainTabView()
}
