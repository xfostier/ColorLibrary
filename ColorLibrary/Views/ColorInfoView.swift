//
//  ColorInfoView.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 20/04/2023.
//

import SwiftUI

private final class CloseColorsLoader: ObservableObject {
    @Published private(set) var colors = [ColorInfo]()
    
    private var timer: Timer?
    
    init() {}
    
    func loadCloseColors(to color: ColorInfo,
                         dataBase: ColorDataBase,
                         distance: CGFloat = 0.8,
                         loadAfter time: TimeInterval = 0) {
        timer?.invalidate()
        
        guard time > 0 else {
            colors = dataBase.closeColors(to: color, distance: distance)
            return
        }
        
        timer = .scheduledTimer(withTimeInterval: time, repeats: false) { [weak self] _ in
            self?.colors = dataBase.closeColors(to: color, distance: distance)
        }
    }
}

struct ColorInfoView: View {
    @EnvironmentObject private var colorDataBase: ColorDataBase
    @ObservedObject private(set) var info: ColorInfo
    @StateObject private var closeColorsLoader = CloseColorsLoader()
    let showsCloseColors: Bool
    
    init(_ info: ColorInfo, showsCloseColors: Bool = true) {
        self.info = info
        self.showsCloseColors = showsCloseColors
    }
    
    @ScaledMetric private var closeColorsViewHeight = 85
    @ScaledMetric private var closeColorsItemWidth = 60
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                ColorCircle(info, scale: 3)
                
                TextField("Title", text: $info.title)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 200)
            }
            
            Spacer()
            
            slidersView
            
            Spacer()
            
            if showsCloseColors {
                if !closeColorsLoader.colors.isEmpty {
                    closeColorsView(closeColorsLoader.colors)
                }
            }
        }.onReceive(info.objectWillChange) {
            closeColorsLoader.loadCloseColors(to: info,
                                              dataBase: colorDataBase,
                                              loadAfter: 0.2)
        }.onAppear {
            closeColorsLoader.loadCloseColors(to: info,
                                              dataBase: colorDataBase)
        }
    }
    
    private var slidersView: some View {
        Grid(alignment: .trailing) {
            GridRow {
                Text("Red").bold()
                ColorSlider(value: $info.red,
                            leading: info.red(0).uiColor,
                            trailing: info.red(1).uiColor)
                Text(String(format: "%0.2f", info.red))
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            GridRow {
                Text("Green").bold()
                ColorSlider(value: $info.green,
                            leading: info.green(0).uiColor,
                            trailing: info.green(1).uiColor)
                Text(String(format: "%0.2f", info.green))
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            GridRow {
                Text("Blue").bold()
                ColorSlider(value: $info.blue,
                            leading: info.blue(0).uiColor,
                            trailing: info.blue(1).uiColor)
                Text(String(format: "%0.2f", info.blue))
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
        }.padding(.horizontal, 16)
    }
    
    private func closeColorsView(_ closeColors: [ColorInfo]) -> some View {
        VStack(alignment: .leading) {
            Text("Close colors")
                .font(.title3).bold()
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(closeColors) { color in
                        NavigationLink(value: color) {
                            VStack {
                                ColorCircle(color, scale: 2)
                                Text(color.title)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: closeColorsItemWidth)
                        }
                    }
                }.padding(.horizontal, 16)
            }.frame(height: closeColorsViewHeight)
        }
    }
}

struct ColorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ColorInfoView(.cantaloupe, showsCloseColors: true)
            .environmentObject(ColorDataBase.demo)
    }
}
