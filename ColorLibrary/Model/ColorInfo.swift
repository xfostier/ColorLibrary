//
//  ColorInfo.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import Foundation

final class ColorInfo: Identifiable, Hashable, ObservableObject {
    @Published var title: String
    
    let id: UUID
    
    @Published var red: CGFloat
    @Published var green: CGFloat
    @Published var blue: CGFloat
    
    init(title: String, red: CGFloat, green: CGFloat, blue: CGFloat, id: UUID = UUID()) {
        self.title = title
        self.red = red
        self.green = green
        self.blue = blue
        self.id = id
    }
    
    static func == (lhs: ColorInfo, rhs: ColorInfo) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.red == rhs.red &&
        lhs.green == rhs.green &&
        lhs.blue == rhs.blue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(id)
        hasher.combine(red)
        hasher.combine(green)
        hasher.combine(blue)
    }
    
    func red(_ value: CGFloat) -> ColorInfo {
        .init(title: title, red: value, green: green, blue: blue)
    }
    
    func green(_ value: CGFloat) -> ColorInfo {
        .init(title: title, red: red, green: value, blue: blue)
    }
    
    func blue(_ value: CGFloat) -> ColorInfo {
        .init(title: title, red: red, green: green, blue: value)
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
