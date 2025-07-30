//
//  NavigationTestView.swift
//  AllIn
//
//  Created by KimDogyung on 7/30/25.
//

import SwiftUI

struct NavigationTestView: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            Text("NavigationTestView")
            
            
            Button(action: {
                path.append(NavigationTestRoute.second)
                
            },
                   label: {
                Text("Go to SecondView")
            })
            
            
        }
    }
}


