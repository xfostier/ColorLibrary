//
//  ColorDataBase.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import Foundation

final class ColorDataBase: ObservableObject {
    final let userDefaultKey = "CustomColors"
    @Published private(set) var colors: [ColorInfo]
    private var colorCache: [ColorInfo]
    
    init(colors: [ColorInfo]) {
        self.colors = colors
        self.colorCache = colors
        // Will erase default colors if some exist on disk
        readFromJSON()
    }
    
    func append(_ color: ColorInfo) {
        colors.append(color)
        colorCache = colors
        saveToJSON()
    }
    
    func delete(_ color: ColorInfo) {
        colors.removeAll(where: { color == $0 })
        colorCache = colors
        saveToJSON()
    }
    
    func filter(searchText: String) {
        guard !searchText.isEmpty else {
            colors = colorCache
            return
        }
        colors = colorCache
        colors = colors.filter { $0.title.lowercased().contains(searchText.lowercased()) }
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
    
    func saveToJSON() {
        do {
            let file = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("color_library.json")
            
            try JSONEncoder()
                .encode(colors)
                .write(to: file)
        } catch {
            print("Failure when saving datas")
        }
    }
    
    func readFromJSON() {
        do {
            let file = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("color_library.json")
            
            let datas = try Data(contentsOf: file)
            colors = try JSONDecoder().decode([ColorInfo].self, from: datas)
            colorCache = colors
        } catch {
            print("Failure when reading datas")
        }
    }
}
