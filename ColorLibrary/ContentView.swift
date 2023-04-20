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
        NavigationStack {
            List {
                ForEach(colors) { color in
                    NavigationLink {
                        Text(color.title)
                    } label: {
                        ColorInfoRow(color)
                    }
                }
            }
            .navigationTitle("Colors")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
