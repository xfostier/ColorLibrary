//
//  ColorDataBase.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import Foundation

final class ColorDataBase: ObservableObject {
    @Published private(set) var colors: [ColorInfo]
    
    init(colors: [ColorInfo]) {
        self.colors = colors
    }
    
    func append(_ color: ColorInfo) {
        colors.append(color)
    }
    
    static var demo: ColorDataBase {
        .init(colors: [.blue, .cantaloupe, .carnation, .eggPlant, .green, .lemon, .orchid, .red, .salmon, .seaFoam])
    }
}
