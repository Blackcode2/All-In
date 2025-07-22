//
//  CustomCamera.swift
//  AllIn
//
//  Created by KimDogyung on 7/21/25.
//

import SwiftUI


struct CustomCameraView: View {
    
    @State private var capturedImage : UIImage? = nil
    @State private var isCustomCameraViewPresented = false
    
    var body: some View {
        ZStack{
            if capturedImage != nil {
                Image(uiImage: capturedImage!).resizable().scaledToFill().ignoresSafeArea()
            }else{
                Color(UIColor.systemBackground)
            }
            VStack{
                Spacer()
                Button(action: {
                    isCustomCameraViewPresented.toggle()
                },
                       label: {
                    Image(systemName:"camera.fill").font(.largeTitle).padding().background(Color.black).foregroundColor(.white).clipShape(Circle())}).padding(.bottom).sheet(isPresented: $isCustomCameraViewPresented, content: {CameraLayerView(capturedImage: $capturedImage)}
                    )
                // 실시간으로 카메라 영상이 보이는 화면 표시
            }
        }
        
    }
}
