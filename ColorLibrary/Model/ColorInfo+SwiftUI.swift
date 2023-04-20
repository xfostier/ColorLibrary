//
//  ColorInfo+SwiftUI.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import Foundation
import SwiftUI

extension ColorInfo {
    var uiColor: Color {
        .init(red: red, green: green, blue: blue)
    }
}
