//
//  CameraService.swift
//  AllIn
//
//  Created by KimDogyung on 7/21/25.
//

import Foundation
import AVFoundation

class CameraService {
    // 전체에 적용되는 세션
    var session : AVCaptureSession?
    // 속성 설정,캡처 동작을 구성하고 입력 장치의 데이터 흐름을 조정하여 출력을 캡처하는 개체입니다.
    var delegate : AVCapturePhotoCaptureDelegate? // 진행 상황을 모니터링하고 사진 캡처 출력에서 ​​결과를 수신하는 방법입니다.
    
    // 카메라 뷰에 넣을 대리인
    let output = AVCapturePhotoOutput()
    // 미리 보기 레이어, 이 미리보기 레이어가 UIViewController에 추가될 예정
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    
    // 실행시켰을떄 권한을 확인하기 위함
    func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping(Error?) -> ()){
        self.delegate = delegate // 권한을 확인하려고함
        checkPermission(completion: completion)
    }
    
    private func checkPermission(completion: @escaping(Error?)->Void){
        
        // 비디오에 대한 승인 상태를 확인
        switch AVCaptureDevice.authorizationStatus(for: .video){
            
        case .notDetermined:
            // 권한을 요청함
            AVCaptureDevice.requestAccess(for: .video){ [weak self] granted in // 백그라운드 스레드 내부에 있기에 weak self 추가
                guard granted else { return }
                // 권한설정이 true면 아래의 코드 실행
                DispatchQueue.main.async {
                    self?.setupCamera(completion: completion)
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            // 승인된 상태일때 카메라 시작
            setupCamera(completion: completion)
        @unknown default:
            break
        }
    }
    
    // 카메라 설정
    private func setupCamera(completion: @escaping (Error?) -> Void) {
        let session = AVCaptureSession()
        guard
            let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input),
            session.canAddOutput(output)
        else {
            completion(CameraError.configurationFailed)
            return
        }
        
        session.addInput(input)
        session.addOutput(output)
        
        previewLayer.session = session
        previewLayer.videoGravity = .resizeAspectFill
        
        session.startRunning()
        self.session = session
        completion(nil)
    }
    
    enum CameraError: Error {
        case noPermission, configurationFailed
    }
    
    func capturePhoto(with settings : AVCapturePhotoSettings = AVCapturePhotoSettings()){
        // 기본 셋팅과 대리인을 전달한다
        output.capturePhoto(with: settings, delegate: delegate!)
    }
    // 카메라 버튼을 눌렀을때 실행되는 함수
    
}
