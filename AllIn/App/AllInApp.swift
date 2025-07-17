//
//  AllInApp.swift
//  AllIn
//
//  Created by KimDogyung on 7/17/25.
//

import SwiftUI

@main
struct AllInApp: App {
    
    init() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        // configureWithOpaqueBackground() - 불투명 배경, 시스템 기본 블러(효과)나 반투명 효과 없이, 오직 backgroundColor에 지정한 색만 보임
//        // configureWithDefaultBackground() - 시스템 기본 배경 스타일 적용, iOS 버전에 따라 적당한 블러(blur) 혹은 반투명 효과가 자동으로 설정, 라이트&다크 자동
//        // configureWithTransparentBackground() - 완전 투명(transparent) 배경을 설정
//        appearance.backgroundColor = UIColor.systemBackground
        
        
//        UITabBar.appearance().tintColor = .red
//        UITabBar.appearance().unselectedItemTintColor = .systemGray
//        UITabBar.appearance().standardAppearance = appearance
//        if #available(iOS 15.0, *) {
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
    }
}
