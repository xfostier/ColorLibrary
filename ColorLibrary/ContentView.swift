//
//  ContentView.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var colorDataBase = ColorDataBase.demo
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(colorDataBase.colors) { color in
                    NavigationLink(value: color) {
                        ColorInfoRow(color)
                    }
                }
            }
            .navigationTitle("Colors")
            .navigationDestination(for: ColorInfo.self) { color in
                ColorInfoView(color, closeColors: [.eggPlant, .orchid])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        colorDataBase.append(.eggPlant)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
