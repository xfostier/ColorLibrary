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
        ZStack {
            Capsule(style: .continuous)
                .foregroundStyle(
                    LinearGradient(colors: [leadingColor, trailingColor],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
            
            Circle().fill(.white)
                .padding(4)
                .shadow(color: .black.opacity(0.3), radius: 4)
        }
        .frame(height: height)
    }
}

struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(value: .init(get: { 0.4 }, set: { _ in }),
                    leading: .cyan, trailing: .orange)
    }
}
