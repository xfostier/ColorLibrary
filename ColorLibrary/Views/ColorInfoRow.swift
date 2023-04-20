//
//  ColorInfoRow.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ColorInfoRow: View {
    @ObservedObject private(set) var info: ColorInfo
    
    init(_ info: ColorInfo) {
        self.info = info
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ColorCircle(info)
            
            VStack(alignment: .leading) {
                Text(info.title)
                
                HStack {
                    colorValueView(for: info.red, text: "Red")
                    colorValueView(for: info.green, text: "Green")
                    colorValueView(for: info.blue, text: "Blue")
                }
            }
        }
    }
    
    private func colorValueView(for value: CGFloat, text: String) -> some View {
        Text("\(text): \(String(format: "%.2f", value))")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

struct ColorInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        ColorInfoRow(.carnation)
    }
}
