//
//  BlueToothView.swift
//  AllIn
//
//  Created by KimDogyung on 8/8/25.
//

import SwiftUI


struct BlueToothView: View {
    @ObservedObject private var vm = BlueToothViewModel()
    
    @State private var animate = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                myDevice
                    .position(x: geo.size.width/2,
                              y: geo.size.height/2)
                
                ForEach(0..<3) { index in
                    Circle()
                        .stroke(Color.blue.opacity(0.8), lineWidth: 2)   // 두께 2짜리 테두리
                        .frame(width: 50, height: 50)                     // 시작 크기
                        .scaleEffect(animate ? 9 : 0.1)                   // 커지는 비율
                        .opacity(animate ? 0 : 1)                         // 커지면서 투명해짐
                        .animation(
                            .easeOut(duration: 2.0)                       // 부드러운 이징
                                .repeatForever(autoreverses: false)       // 반복하되 반전은 없음
                                .delay(Double(index) * 0.5),              // 각 원마다 0.5초씩 딜레이
                            value: animate
                        )
                        .position(x: geo.size.width/2,
                                  y: geo.size.height/2)
                }
                
                
                ForEach(Array(vm.peripherals.enumerated()), id: \.element.identifier) { idx, peripheral in
                    let count = vm.peripherals.count
                    // 기기별로 0 ~ 2π 사이 각도 분배
                    let angle = Double(idx) / Double(max(count,1)) * 2 * .pi
                    // 반지름: 화면 크기에 맞게
                    let radius = min(geo.size.width, geo.size.height) * 0.3
                    
                    VStack {
                        otherDevice
                        Text(peripheral.name ?? "Unknown")
                            .font(.caption)
                    }
                    // 중심으로부터 polar → cartesian 변환
                    .position(
                        x: geo.size.width/2 + CGFloat(cos(angle)) * radius,
                        y: geo.size.height/2 + CGFloat(sin(angle)) * radius
                    )
                }
                
                
            }
        }
        .onAppear {
            animate = true
            vm.startScanning()
        }
        .onDisappear {
            vm.stopScanning()
        }
    }
    
    
    
    private var myDevice: some View {
        Image(systemName: "antenna.radiowaves.left.and.right")
            .foregroundStyle(.black)
            .font(.system(size: 60))
            .padding(30)
            .background(.blue.opacity(0.6))
            .clipShape(Circle())
    }
    
    
    private var otherDevice: some View {
        Image(systemName: "figure.arms.open")
            .foregroundStyle(.black)
            .font(.system(size: 30))
            .padding(16)
            .background(.green.opacity(0.6))
            .clipShape(Circle())
    }
    
}



#Preview {
    BlueToothView()
}
