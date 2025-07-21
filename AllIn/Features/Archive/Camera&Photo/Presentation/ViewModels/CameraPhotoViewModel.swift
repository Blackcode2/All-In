//
//  CameraPhotoViewModel.swift
//  AllIn
//
//  Created by KimDogyung on 7/20/25.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers

@MainActor
final class CameraPhotoViewModel: ObservableObject {
    @Published var capturedImage: UIImage?
    @Published var capturedVideoURL: URL?
    @Published var isPresenting = false

    func openCamera() {
        isPresenting = true
    }
}

/// UIKit의 UIImagePickerController를 SwiftUI에서 쓸 수 있게 해 주는 래퍼
///  UIKit의 UIImagePickerController 를 SwiftUI에서 쓰기 위해서 UIViewControllerRepresentable 프로토콜 구현
struct ImagePicker: UIViewControllerRepresentable {
    enum MediaType {
        case photo, video, both
    }
    /// .camera 또는 .photoLibrary
    var sourceType: UIImagePickerController.SourceType = .camera
    var capture: MediaType = .both
    
    /// 촬영/선택된 이미지를 바인딩으로 전달
    @Binding var image: UIImage?
    @Binding var videoURL: URL?
    /// 모달 닫힘 제어
    @Environment(\.dismiss) private var dismiss
    
    // MARK: UIViewControllerRepresentable
    
    // Context -> Representable 뷰의 실행 환경 정보 (coordinator, environment, transaction 정보 담음)
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController() // 카메라나 사진 라이브러리를 띄워 주는 표준 UIKit 컨트롤러
        picker.sourceType = sourceType
        
        switch capture {
        case .photo:
            picker.mediaTypes = [UTType.image.identifier]
        case .video:
            picker.mediaTypes = [UTType.movie.identifier]
        case .both:
            picker.mediaTypes = [UTType.image.identifier, UTType.movie.identifier]
        }
        
        if capture != .photo {
            picker.cameraCaptureMode = .video
            picker.videoQuality = .typeHigh
        }
        
        
        picker.delegate = context.coordinator   // 델리게이트를 Coordinator로 지정
                                                // 사진 촬영 완료나 취소 시, Coordinator 내부의 델리게이트 메서드가 호출돼서 선택된 이미지를 바인딩에 전달하고 모달을 닫습니다.
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: Context) {
        // 보통 빈 구현
    }
   
    // UIViewControllerRepresentable을 생성할 때 한 번만 호출해서, UIKit 델리게이트 콜백을 처리할 “중간자”(Coordinator) 객체를 만들어 주는 역할
    func makeCoordinator() -> Coordinator {
        Coordinator(self) // init(_ parent: ImagePicker) 에 self (즉, 현재의 ImagePicker 인스턴스) 를 넘겨 줍니다.
    }
    
    // MARK: Coordinator
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // 사진 촬영/선택 후 호출
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let url = info[.mediaURL] as? URL {
                parent.videoURL = url
            }
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
