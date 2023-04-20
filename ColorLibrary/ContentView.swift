//
//  ContentView.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [ColorInfo] = [.blue, .cantaloupe, .carnation, .eggPlant, .green, .lemon, .orchid, .red, .salmon, .seaFoam]
    
    var body: some View {
        List {
            ForEach(colors, id: \.title) { color in
                ColorInfoRow(color)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
