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
                ArchiveView()
            }
            .tabItem {
                Image(systemName: "archivebox")
                Text("Archive")
            }
            .tag(Tab.search)
            
            // chat
            NavigationStack {
                Text("Chating")
            }
            .tabItem {
                Image(systemName: "message")
                Text("Caht")
            }
            .tag(Tab.profile)
            
            // profile
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
