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
                    
                    Text("Carousel")
                        .title3()
                        .foregroundStyle(Color.textPrimary)
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .padding(.top, 20)
                    
                    SimpleCarouselView()
                    
                    CategoryButtons()
                    
                    
                    
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



struct CategoryButtons: View {
    
    enum Category: String, CaseIterable, Identifiable {
        case all
        case fashion
        case beauty
        
        var id: Self { self }
        var title: String { rawValue.capitalized }
    }
    
    @State private var selected: Category = .all
    
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.self) { tag in
                Button {
                    print("pressed \(tag.rawValue)")
                    selected = tag
                } label: {
                    Text(tag.title)
                        .body2()
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            // ③ 선택된 버튼만 배경색
                            selected == tag
                            ? Color.blue
                            : Color.clear
                        )
                        .foregroundColor(
                            // ④ 선택 여부에 따라 텍스트 색
                            selected == tag
                            ? .white
                            : .primary
                        )
                        .cornerRadius(8)
                }
                .padding(.horizontal, 8)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.secondary)
        .cornerRadius(16)
    }
}

fileprivate struct CategoryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        // 레이블 위에 패딩과 배경을 줍
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                // 버튼이 눌리면 회색, 아니면 파란색
                Capsule()
                    .fill(configuration.isPressed ? Color.gray : Color.blue)
            )
            .foregroundColor(.white)
        // 눌릴 때 잠깐 작아졌다가 돌아오는 스케일 애니메이션
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
}
