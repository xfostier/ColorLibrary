//
//  ColorInfoView.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ColorInfoView: View {
    @State private(set) var info: ColorInfo
    let closeColors: [ColorInfo]
    
    init(_ info: ColorInfo, closeColors: [ColorInfo] = []) {
        self._info = State(initialValue: info)
        self.closeColors = closeColors
    }
    
    @ScaledMetric private var closeColorsViewHeight = 85
    @ScaledMetric private var closeColorsItemWidth = 60
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                ColorCircle(info, scale: 3)
                
                TextField("Title", text: $info.title)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 200)
            }
            
            Spacer()
            
            VStack {
                ColorSlider(value: $info.red, leading: .black, trailing: .white)
                ColorSlider(value: $info.green, leading: .black, trailing: .white)
                ColorSlider(value: $info.blue, leading: .black, trailing: .white)
            }.padding(.horizontal, 16)
            
            Spacer()
            
            if !closeColors.isEmpty {
                closeColorsView
            }
        }
    }
    
    private var closeColorsView: some View {
        VStack(alignment: .leading) {
            Text("Close colors")
                .font(.title3).bold()
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(closeColors) { color in
                        NavigationLink(value: color) {
                            VStack {
                                ColorCircle(color, scale: 2)
                                Text(color.title)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: closeColorsItemWidth)
                        }
                    }
                }.padding(.horizontal, 16)
            }.frame(height: closeColorsViewHeight)
        }
    }
}

struct ColorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ColorInfoView(.cantaloupe, closeColors: [.blue, .lemon])
    }
}
