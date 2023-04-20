//
//  ColorInfoView.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ColorInfoView: View {
    let info: ColorInfo
    let closeColors: [ColorInfo]
    
    init(_ info: ColorInfo, closeColors: [ColorInfo] = []) {
        self.info = info
        self.closeColors = closeColors
    }
    
    @ScaledMetric private var closeColorsViewHeight = 85
    @ScaledMetric private var closeColorsItemWidth = 60
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                ColorCircle(info, scale: 3)
                
                Text(info.title)
            }
            
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
                        NavigationLink {
                            ColorInfoView(color, closeColors: [.red, .salmon])
                        } label: {
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
