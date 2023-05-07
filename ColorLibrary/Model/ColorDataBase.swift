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
    
    func closeColors(to color: ColorInfo, distance maxDistance: CGFloat) throws -> [ColorInfo] {
        try colors
            .map { ($0, $0.distance(to: color)) }
            .filter { (_, distance) in distance > 0.00001 && distance <= maxDistance }
            .sorted { lhs, rhs in
                try Task.checkCancellation()
                return lhs.1 < rhs.1
            }
            .map { (color, _) in color }
    }
    
    static var demo: ColorDataBase {
        .init(colors: [.blue, .cantaloupe, .carnation, .eggPlant, .green, .lemon, .orchid, .red, .salmon, .seaFoam])
    }
}
