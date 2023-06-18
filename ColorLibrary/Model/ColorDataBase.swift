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
        let defaults = UserDefaults.standard
        do {
            let datas = defaults.data(forKey: userDefaultKey)
            guard let datas else { return }
            // Erase default array if datas in UserDefaults
            self.colors = try JSONDecoder().decode([ColorInfo].self, from: datas)
            self.colorCache = self.colors
        } catch {
            print("Nothing happen")
        }
    }
    
    func append(_ color: ColorInfo) {
        colors.append(color)
        do {
            let datas = try JSONEncoder().encode(colors)
            let defaults = UserDefaults.standard
            
            defaults.set(datas, forKey: userDefaultKey)
        } catch {
            print("Nothing happen")
        }
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
}
