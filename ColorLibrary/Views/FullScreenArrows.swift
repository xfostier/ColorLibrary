//
//  FullScreenArrows.swift
//  ColorLibrary
//
//  Created by Vivien BERNARD on 07/05/2023.
//

import SwiftUI

struct FullScreenArrows: Shape {
    let arrowLength: CGFloat // Between 0 and 1
    let tipSize: CGFloat // Between 0 and 1
    private var arrowPosition: CGFloat // Between 0 and 1
    
    var animatableData: CGFloat {
        get { arrowPosition }
        set { arrowPosition = newValue }
    }
    
    init(isFullScreen: Bool, arrowLength: CGFloat = 0.8, tipSize: CGFloat = 0.6) {
        self.arrowLength = arrowLength
        self.tipSize = tipSize
        self.arrowPosition = isFullScreen ? 1 : 0
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let arrowHeight = rect.height * arrowLength / 2
            let arrowWidth = rect.width * arrowLength / 2
            let tipHeight = rect.height * tipSize / 2
            let tipWidth = rect.width * tipSize / 2
            
            let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
            let bottomLeftCenter = CGPoint(x: rect.minX + arrowWidth, y: rect.maxY - arrowHeight)
            let topRight = CGPoint(x: rect.maxX, y: rect.minY)
            let topRightCenter = CGPoint(x: rect.maxX - arrowWidth, y: rect.minY + arrowHeight)
            
            path.move(to: bottomLeft)
            path.addLine(to: bottomLeftCenter)
            
            path.move(to: point(between: bottomLeft.translated(y: -tipHeight),
                                and: bottomLeftCenter.translated(x: -tipWidth)))
            path.addLine(to: point(between: bottomLeft,
                                   and: bottomLeftCenter))
            path.addLine(to: point(between: bottomLeft.translated(x: tipWidth),
                                   and: bottomLeftCenter.translated(y: tipHeight)))
            
            path.move(to: point(between: topRight.translated(x: -tipWidth),
                                and: topRightCenter.translated(y: -tipHeight)))
            path.addLine(to: point(between: topRight,
                                   and: topRightCenter))
            path.addLine(to: point(between: topRight.translated(y: tipHeight),
                                   and: topRightCenter.translated(x: tipWidth)))
            
            path.move(to: topRight)
            path.addLine(to: topRightCenter)
        }
    }
    
    private func point(between pointA: CGPoint, and pointB: CGPoint) -> CGPoint {
        CGPoint(x: pointA.x * arrowPosition + pointB.x * (1 - arrowPosition),
                y: pointA.y * arrowPosition + pointB.y * (1 - arrowPosition))
    }
}

private extension CGPoint {
    func translated(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
        CGPoint(x: self.x + x, y: self.y + y)
    }
}
