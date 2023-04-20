//
//  ColorInfoView.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ColorInfoView: View {
    let info: ColorInfo
    
    init(_ info: ColorInfo) {
        self.info = info
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ColorCircle(info, scale: 3)
            
            Text(info.title)
        }
    }
}

struct ColorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ColorInfoView(.cantaloupe)
    }
}
