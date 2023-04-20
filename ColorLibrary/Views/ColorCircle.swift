//
//  ColorCircle.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ColorCircle: View {
    @ObservedObject private(set) var info: ColorInfo
    let scale: CGFloat
    
    init(_ info: ColorInfo, scale: CGFloat = 1) {
        self.info = info
        self.scale = scale
    }
    
    @ScaledMetric private var scaledSize: CGFloat = 30
    private var size: CGFloat { scaledSize * scale }
    private let lineWidth: CGFloat = 3
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: lineWidth)
            .foregroundColor(info.uiColor.opacity(0.3))
            .frame(width: size, height: size)
            .background(Circle().fill(info.uiColor.gradient).padding(lineWidth))
    }
}

struct ColorCircle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCircle(.orchid)
    }
}
