//
//  MapView.swift
//  AllIn
//
//  Created by KimDogyung on 7/23/25.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct MapView: View {
    var body: some View {
        VStack(spacing: 0) {
            MapBoxView()
        }
        .appPadding()
    }
}



struct MapBoxView: View {
    @StateObject private var locationManager = LocationManager()
    
    // ① 지도 보여줄 영역(초기값은 임의 좌표)
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                
                NavigationLink(destination: {
                    MapKitView()
                }, label: { Text("MapKit Guide") })
                
                Map(){
                    if let currentLocation = locationManager.lastLocation {
                        Marker("Current", coordinate: currentLocation.coordinate)
                    }
                }
                .frame(height: 200)
                .padding(15)
                .background(.gray.opacity(0.2))
                .cornerRadius(12)
                
                LocationButton(.currentLocation) {
                    // 버튼 누르면 권한 요청 / 위치 업데이트 재시작
                    locationManager.manager.requestWhenInUseAuthorization()
                }
                .labelStyle(.iconOnly)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                .cornerRadius(8)
                
            }
            //        .onAppear() {
            //            // 권한 요청 & 권한 허용 시 업데이트 시작
            //            locationManager.manager.requestWhenInUseAuthorization()
            //        }
        }

    }
    
}
