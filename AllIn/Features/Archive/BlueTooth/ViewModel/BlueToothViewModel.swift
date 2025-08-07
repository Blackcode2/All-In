//
//  BlueToothViewModel.swift
//  AllIn
//
//  Created by KimDogyung on 8/8/25.
//

import SwiftUI
import CoreBluetooth

class BlueToothViewModel: NSObject, ObservableObject {
    @Published var peripherals: [CBPeripheral] = []
    
    private var central: CBCentralManager!
    
    override init() {
        super.init()
        // ① CBCentralManager 생성 (delegate: self, 큐: main)
        central = CBCentralManager(delegate: self, queue: .main)
    }
    
    /// 스캔 시작
    func startScanning() {
        guard central.state == .poweredOn else { return }
        // ② 모든 서비스 UUID에 대해 스캔
        central.scanForPeripherals(withServices: nil, options: nil)
        
        // 1️⃣ withServices: 검색할 서비스 UUID 필터
        //    - nil: 모든 서비스 UUID를 가진 주변 장치를 대상
        //    - [CBUUID(string: "..."), ...]: 특정 서비스 UUID를 광고하는 장치만 탐색

        // 2️⃣ options: 스캔 동작을 세부 제어하는 옵션 딕셔너리
        //    - nil: 기본 스캔 설정 사용
        //    - [CBCentralManagerScanOptionAllowDuplicatesKey: true]:
        //        • 중복된 광고 패킷을 계속 받을지 여부
        //        • 기본값(false)이면 같은 광고는 한 번만 콜백
        //    - [CBCentralManagerScanOptionSolicitedServiceUUIDsKey: [...]]:
        //        • 특정 서비스 요청 패킷을 함께 찾도록 요청
    }
    
    /// 스캔 중단
    func stopScanning() {
        central.stopScan()
    }
}


// 2) CBCentralManagerDelegate
extension BlueToothViewModel: CBCentralManagerDelegate {
    // 블루투스 상태 변경
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            // 전원이 켜지면 자동 스캔 시작
            startScanning()
        default:
            // 그 외 상태: 스캔 중단
            stopScanning()
            peripherals.removeAll()
        }
    }
    
    // 주변 장치 발견 콜백
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        // 중복 추가 방지
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
        }
    }
}
