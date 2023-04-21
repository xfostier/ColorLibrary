//
//  ColorLibraryApp.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

@main
struct ColorLibraryApp: App {
    private let colorDataBase = ColorDataBase.demo
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(colorDataBase)
        }
    }
}
