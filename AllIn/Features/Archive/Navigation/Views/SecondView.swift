//
//  SecondView.swift
//  AllIn
//
//  Created by KimDogyung on 7/30/25.
//

import SwiftUI

struct SecondView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        VStack {
            Text("Second View")
            
            
            Button(action: {
                path.append(NavigationTestRoute.third)
                
            },
                   label: {
                Text("Go to ThirdView")
            })

            
        }
    }
}
