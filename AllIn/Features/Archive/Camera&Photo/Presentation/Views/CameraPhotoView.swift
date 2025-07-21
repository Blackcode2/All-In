//
//  CameraPhotoView.swift
//  AllIn
//
//  Created by KimDogyung on 7/20/25.
//

import SwiftUI
import AVKit

struct CameraPhotoView: View {
    @StateObject private var viewModel = CameraPhotoViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            if let img = viewModel.capturedImage {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
            } else if let url = viewModel.capturedVideoURL {
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(height: 300)
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
            ImagePicker(sourceType: .camera, capture: .both, image: $viewModel.capturedImage, videoURL: $viewModel.capturedVideoURL)
                .ignoresSafeArea()
            }
        
    }
}



