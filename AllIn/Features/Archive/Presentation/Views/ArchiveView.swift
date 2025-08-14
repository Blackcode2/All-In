//
//  ArchiveView.swift
//  AllIn
//
//  Created by KimDogyung on 7/20/25.
//

import SwiftUI


enum NavigationTestRoute: Hashable {
    case navigationTest
    case second
    case third
}

struct ArchiveView: View {
    
    @State private var path: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                Grid() {
                    GridRow{
                        NavigationLink(){
                            CameraPhotoView()
                        } label: {
                            ArchiveCardView(title: "Camera&Photo", description: "Camera & Photo picker")
                        }
                        
                        NavigationLink(){
                            CustomCameraView()
                        } label: {
                            ArchiveCardView(title: "Custom Camera", description: "Custom camera test")
                        }
                        
                        
                    }
                    
                    GridRow{
                        NavigationLink(){
                            SegmentButtonView()
                        } label: {
                            ArchiveCardView(title: "Menu Button", description: "Several version of menu buttons")
                        }
                        
                        NavigationLink(){
                            MapView()
                        } label: {
                            ArchiveCardView(title: "Map", description: "Everything about map")
                        }
                    }
                    
                    GridRow{

                        
                        ArchiveCardView(title: "Navigation", description: "Navigation Test")
                            .onTapGesture { path.append(NavigationTestRoute.navigationTest) }
                        
                        
                    
                        NavigationLink(){
                           BlueToothView()
                        } label: {
                            ArchiveCardView(title: "BlueTooth", description: "BlueTooth Test")
                        }
                    }
                    
                    
                    GridRow{

                    
                        NavigationLink(){
                           ProductListView()
                        } label: {
                            ArchiveCardView(title: "Alamofire", description: "API CRUD Test")
                        }
                    }
                    
                }
                
            }
            .appPadding()
        }
        .background(Color.mainBackground.ignoresSafeArea())
        .navigationDestination(for: NavigationTestRoute.self) { route in
            switch route {
            case .navigationTest:
                NavigationTestView(path: $path)
                    .toolbarVisibility(.hidden, for: .tabBar) // 이걸로 탭바 안나오게 가능
            case .second:
                SecondView(path: $path)
            case .third:
                ThirdView(path: $path)
            }
        }
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


#Preview {
    ArchiveView()
}

