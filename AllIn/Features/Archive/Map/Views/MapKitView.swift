//
//  MapKitView.swift
//  AllIn
//
//  Created by KimDogyung on 7/23/25.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 42.354528, longitude: -71.068369)
}


extension MKCoordinateRegion {
    static let boston = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.360256,
            longitude: -71.057279),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1
        )
    )
    
    static let northShore = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.547408,
            longitude: -70.870085),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
        )
    )
}


struct MapKitView: View {
    @Environment(\.dismiss) private var dismiss
   
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    
    var body: some View {
        
            
            Map(position: $position, selection: $selectedResult){
                Annotation("Parking", coordinate: .parking) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.background)
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondary, lineWidth: 5)
                        Image(systemName: "car")
                            .padding(5)
                    }
                }
                .annotationTitles(.hidden)
                
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                
                if let route = route {
                    MapPolyline(route)
                        .stroke(.blue, lineWidth: 5)
                }
                
                UserAnnotation()
                
            }
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    
                    
                    
                    BeantownButtons(
                        position: $position,
                        searchResults: $searchResults,
                        visibleRegion: visibleRegion
                    )
                    
                    Spacer()
                    
                }
            }
            .onChange(of: searchResults) {
                // searchResults 값이 바뀔때마다 MapCameraPosition 자동으로 바꿔줌
                // 결과가 나오는 지역으로 화면 위치를 자동으로 업데이트
                position = .automatic
            }
            .onChange(of: selectedResult) {
                getDirections()
            }
            .onMapCameraChange { context in
                // 사용자가 지도 움직이는 걸 끝내면 변화를 감지함
                // 바뀐 지도 위치를 visibleRegion에 담음
                // 검색할때 바뀐 위치에서 검색을 해줌
                visibleRegion = context.region
            }
            
            
            
//            Button {
//                dismiss()
//            } label: {
//                Image(systemName: "chevron.left")
//                    .font(.title2)
//                    .padding(8)
//                    .background(.ultraThinMaterial) // 반투명 블러 배경
//                    .clipShape(Circle())
//            }
//            .padding(.top, 0)                      // 상태바 여유 공간
//            .padding(.leading, 16)
        
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
    }
    
    func getDirections() {
        route = nil
        guard let selectedResult else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: .parking))
        request.destination = selectedResult
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
        
    }
    
    
}


struct BeantownButtons: View {
    
    @Binding var position: MapCameraPosition
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegion: MKCoordinateRegion?
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(center:.parking, span: MKCoordinateSpan( latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
    
    var body: some View {
        HStack {
            Button(
                action: {search(for: "playground")},
                label: {
                    Label("Playground", systemImage: "figure.and.child.holdinghands")
                }
            )
            .buttonStyle(.borderedProminent)
            
            Button(
                action: {search(for: "beach")},
                label: {
                    Label("Beaches", systemImage: "beach.umbrella")
                }
            )
            .buttonStyle(.borderedProminent)
            
            Button(
                action: {
                    position = .region(.boston)
                },
                label: {
                    Label("Boston", systemImage: "building.2")
                }
            )
            .buttonStyle(.bordered)
            
            Button(
                action: {
                    position = .region(.northShore)
                },
                label: {
                    Label("North Shore", systemImage: "water.waves")
                }
            )
            .buttonStyle(.bordered)
            
        }
        .labelStyle(.iconOnly)
    }
    
    
}


#Preview {
    MapKitView()
}
