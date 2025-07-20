//
//  CameraPhotoView.swift
//  AllIn
//
//  Created by KimDogyung on 7/20/25.
//

import SwiftUI


struct CameraPhotoView: View {
    @StateObject private var viewModel = CameraPhotoViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            if let img = viewModel.capturedImage {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No photo yet")
            }
            
            Button(
                action: {
                    viewModel.openCamera()
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
        .fullScreenCover(isPresented: $viewModel.isPresenting) {
            ImagePicker(sourceType: .camera, image: $viewModel.capturedImage)
                .ignoresSafeArea()
            }
        
    }
}



