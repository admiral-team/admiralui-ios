//
//  Line.swift
//  AdmiralSwiftUI
//
//  Created on 14.05.2021.
//

import SwiftUI

/**
 SeparatorLineMode - Public enum for Line.
 
 SeparatorLineMode can be one of the following values:
 - solid - Solid mode used to draw single solid line.
 - dashed(lineWidth: CGFloat, dash: CGFloat) - Dased mode used to draw dash line.
 
 The default value is normal state:
 - var `default`: TextInputState - default is normal
 */
/// Line mode.
enum SeparatorLineMode {
    /// Solid mode used to draw single solid line.
    case solid
    /// Dased mode used to draw dash line.
    case dashed(lineWidth: CGFloat, dash: CGFloat)
}

/**
 Line - Shape lone.
 
 You can create a StandardTextField with the zero frame rectangle by specifying the following parameters in init:
 - mode: SeparatorLineMode - Line mode.
 
 Also SecurityTextField has public func to get outline of a 2D shape of Line.
 # Code
 ```
 public func path(in rect: CGRect) -> Path
 ```
 */
@available(iOS 14.0.0, *)
struct Line: Shape {
    
    var mode: SeparatorLineMode = .solid
    
    public var body: some View {
        switch mode {
        case .solid:
            Rectangle()
                .frame(height: 1)
        case .dashed(let lineWidth, let dash):
            Line()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash]))
                .frame(height: 1)
        }

    }
    
    public init() {}
    
    public init(mode: SeparatorLineMode) {
        self.mode = mode
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
    
}
