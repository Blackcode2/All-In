//
//  ArchiveView.swift
//  AllIn
//
//  Created by KimDogyung on 7/20/25.
//

import SwiftUI


struct ArchiveView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                Grid() {
                    GridRow{
                        NavigationLink(){
                            CameraPhotoView()
                        } label: {
                            ArchiveCardView(title: "Camera&Photo", description: "Camera & Photo picker")
                        }
                            
                        
                        ArchiveCardView(title: "test", description: "teste test teste teset")
                    }
                }

            }
            .appPadding()
        }
        .background(Color.mainBackground.ignoresSafeArea())
    }
}





struct ArchiveCardView: View {
    
    let title: String
    let description: String
    
    var cardWidth = .screenWidth * 0.5
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text(title)
                .title3()
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text(description)
                .body1()
                .foregroundStyle(Color.textPrimary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(minHeight: 200, maxHeight: 200)
        .background(Color.randomColor)
        .cornerRadius(8)
    }
}


fileprivate extension Color {
    static var randomColor: Color {
        .init(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
