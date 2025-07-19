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
                VStack(spacing: 20){
                    
                    SimpleCarouselView()
                        .padding(.top, 20)
                    
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


struct Card: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text(card.title)
                .font(.headline)
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(height: 280)
        .frame(width: .screenWidth * 0.5)
        .background(card.color)
        .shadow(radius: 4, y: 2)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
}


struct SimpleCarouselView: View {
    let cards: [Card] = [
        Card(title: "Card 1", color: .red),
        Card(title: "Card 2", color: .red),
        Card(title: "Card 3", color: .red),
        Card(title: "Card 4", color: .red),
    ]
    
    
    var body: some View {
        
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(cards) { card in
                    CardView(card: card)
                        .scrollTransition(.interactive, axis: .horizontal) { effect, phase in
                            effect
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.80)
                        }
                    
                }
            }
            .padding(.horizontal, (.screenWidth - (.screenWidth * 0.5)) / 2)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}





