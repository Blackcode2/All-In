//
//  ContentView.swift
//  AllIn
//
//  Created by KimDogyung on 7/17/25.
//

import SwiftUI

enum Tab { case home, search, profile }

struct MainTabBarView: View {
    
    @State private var selection: Tab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            
            // Home
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(Tab.home)
            
            //
            NavigationStack {
                Text("Second")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(Tab.search)
            
            //
            NavigationStack {
                Text("Third")
            }
            .tabItem {
                Image(systemName: "person.circle")
                Text("Profile")
            }
            .tag(Tab.profile)
            
        }
    
    }
}

#Preview {
    MainTabBarView()
}
