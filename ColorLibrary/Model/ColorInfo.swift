//
//  ColorInfo.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import Foundation

struct ColorInfo: Identifiable, Hashable {
    let title: String
    
    let id: UUID
    
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    
    init(title: String, red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.title = title
        self.red = red
        self.green = green
        self.blue = blue
        self.id = UUID()
    }
}

// MARK: - Colors

extension ColorInfo {
    static var red: ColorInfo {
        .init(title: "Red", red: 255/255, green: 0/255, blue: 0/255)
    }
    
    static var green: ColorInfo {
        .init(title: "Green", red: 0/255, green: 255/255, blue: 0/255)
    }
    
    static var blue: ColorInfo {
        .init(title: "Blue", red: 0/255, green: 0/255, blue: 255/255)
    }
    
    static var salmon: ColorInfo {
        .init(title: "Salmon", red: 255/255, green: 126/255, blue: 121/255)
    }
    
    static var carnation: ColorInfo {
        .init(title: "Carnation", red: 255/255, green: 138/255, blue: 216/255)
    }
    
    static var seaFoam: ColorInfo {
        .init(title: "Sea Foam", red: 0/255, green: 255/255, blue: 146/255)
    }
    
    static var eggPlant: ColorInfo {
        .init(title: "Egg Plant", red: 83/255, green: 27/255, blue: 147/255)
    }
    
    static var lemon: ColorInfo {
        .init(title: "Lemon", red: 255/255, green: 251/255, blue: 0/255)
    }
    
    static var orchid: ColorInfo {
        .init(title: "Orchid", red: 122/255, green: 129/255, blue: 255/255)
    }
    
    static var cantaloupe: ColorInfo {
        .init(title: "Cantaloupe", red: 255/255, green: 212/255, blue: 121/255)
    }
}
