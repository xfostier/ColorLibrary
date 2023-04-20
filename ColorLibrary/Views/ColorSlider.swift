//
//  ColorSlider.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ColorSlider: View {
    @Binding var value: CGFloat
    
    let leadingColor: Color
    let trailingColor: Color
    
    init(value: Binding<CGFloat>,
         leading: Color,
         trailing: Color) {
        _value = value
        
        self.leadingColor = leading
        self.trailingColor = trailing
    }
    
    private let height: CGFloat = 50
    
    var body: some View {
        GeometryReader { proxy in
            let dragGesture = DragGesture(minimumDistance: 2)
                .onChanged { dragValue in
                    value = dragValue.translation.width
                }
            
            Capsule(style: .continuous)
                .foregroundStyle(
                    LinearGradient(colors: [leadingColor, trailingColor],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
            
            Circle().fill(.white)
                .padding(4)
                .shadow(color: .black.opacity(0.3), radius: 4)
                .offset(x: xCoordinates(forContentSize: proxy.size, value: value))
                .gesture(dragGesture)
        }
        .frame(height: height)
    }
    
    private func xCoordinates(forContentSize size: CGSize, value: CGFloat) -> CGFloat {
        value * (size.width - size.height)
    }
}

struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(value: .init(get: { 0.4 }, set: { _ in }),
                    leading: .cyan, trailing: .orange)
    }
}
