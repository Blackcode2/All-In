//
//  ThirdView.swift
//  AllIn
//
//  Created by KimDogyung on 7/30/25.
//

import SwiftUI

struct ThirdView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Text("Third View")
        Button(action: {
            path.removeLast(path.count)
            
        },
               label: {
            Text("Go to Archive")
        })
    }
}
