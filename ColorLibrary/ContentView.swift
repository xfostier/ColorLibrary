//
//  ContentView.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var colorDataBase = ColorDataBase.demo
    @State private var newlyCreatedColor: ColorInfo?
    
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
                        newlyCreatedColor = .init(title: "Some color", red: 0.5, green: 0.5, blue: 0.5)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }.sheet(item: $newlyCreatedColor) { color in
            newColorSheet(for: color)
        }
    }
    
    private func newColorSheet(for color: ColorInfo) -> some View {
        NavigationStack {
            ColorInfoView(color)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            newlyCreatedColor = nil
                        } label: {
                            Text("Cancel")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            colorDataBase.append(color)
                            newlyCreatedColor = nil
                        } label: {
                            Text("Add").bold()
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
