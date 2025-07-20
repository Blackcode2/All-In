//
//  CameraPhotoView.swift
//  AllIn
//
//  Created by KimDogyung on 7/20/25.
//

import SwiftUI


struct CameraPhotoView: View {
    var body: some View {
        VStack(spacing: 0) {
            Button(
                action: {
                    
                }, label: {
                    HStack(spacing: 6){
                        Image(systemName: "camera")
                            .foregroundStyle(Color.white)
                        Text("Camera")
                            .body1()
                            .foregroundStyle(Color.white)
                    }
                }
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.primary)
            .cornerRadius(8)
        }
    }
}



