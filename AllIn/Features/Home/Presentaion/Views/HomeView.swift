//
//  HomeView.swift
//  AllIn
//
//  Created by KimDogyung on 7/17/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(spacing: 0){
                    
                }
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                   Image("main_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 44)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                    }
                }
                
            }
        }
        .appPadding()
        .navigationTitle("홈")
        .navigationBarTitleDisplayMode(.inline)
    }
}
