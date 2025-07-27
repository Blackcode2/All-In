//
//  MenuButtonView.swift
//  AllIn
//
//  Created by KimDogyung on 7/22/25.
//

import SwiftUI

struct SegmentButtonView: View {

    
    var body: some View {
        VStack(spacing: 20) {
            PickerSegmentButton()
            
            MySegmentedControl()
            
            
            CapsulSegmentButton()
            
        }
        .appPadding()
        
    }
}



struct PickerSegmentButton: View {
    
    @State var selectedColor = "color"
    var colors = ["red", "green", "blue", "purple"]
    
    init() {
        let segmentAppearance = UISegmentedControl.appearance()
        segmentAppearance.selectedSegmentTintColor = UIColor.systemBlue
        segmentAppearance.backgroundColor = UIColor.systemGray6
        
        segmentAppearance.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
     
        // 세그먼트 너비 지정 (optional)
        //    각 인덱스별로 폭을 고정할 수도 있습니다.
        //segmentAppearance.setWidth(130, forSegmentAt: 0)
        
        segmentAppearance.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )
        
        segmentAppearance.setTitleTextAttributes(
            [.foregroundColor: UIColor.systemGray],
            for: .normal
        )
        
    }
    
    var body: some View {
        Picker("Choose a color", selection: $selectedColor) {
            ForEach(colors, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.segmented)
    }
}



struct MySegmentedControl: View {
    @State var selectedColor: Int = 0
    var colors = ["red", "green", "blue", "purple"]
//    @Binding var selected: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(colors.indices, id: \.self) { idx in
                Button {
                    selectedColor = idx
                } label: {
                    Text(colors[idx])
                        .fontWeight(selectedColor == idx ? .bold : .regular)
                        .foregroundColor(selectedColor == idx ? .white : .blue)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                if selectedColor == idx {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue)
                                }
                            }
                        )
                }
            }
        }
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


struct CapsulSegmentButton: View {
    @State var selectedColor: Int = 0
    var colors = ["red", "green", "blue", "purple"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(colors.indices, id: \.self) { idx in
                Button(
                    action: {
                        selectedColor = idx
                    },
                    label: {
                        Text(colors[idx])
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity) // 없으면 텍스트 만큼의 최소 크기만 버튼이 차지하고 버튼 크기 제각각
                            .background(
                                ZStack {
                                    if selectedColor == idx {
                                        Capsule()
                                            .fill(Color.red)
                                    }
                                }
                            )
                    }
                )
            }
        }
        .padding(10)
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}



