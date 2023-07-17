//
//  CalendarLine.swift
//  AdmiralCalendarSwiftUI
//
//  Created on 14.05.2021.
//

import SwiftUI

/**
 CalendarSeparatorLineMode - Public enum for Line.

 CalendarSeparatorLineMode can be one of the following values:
 - solid - Solid mode used to draw single solid line.
 - dashed(lineWidth: CGFloat, dash: CGFloat) - Dased mode used to draw dash line.

 The default value is normal state:
 - var `default`: TextInputState - default is normal
 */
/// Line mode.
enum CalendarSeparatorLineMode {
    /// Solid mode used to draw single solid line.
    case solid
    /// Dased mode used to draw dash line.
    case dashed(lineWidth: CGFloat, dash: CGFloat)
}

/**
 CalendarLine - Shape lone.

 You can create a CalendarLine with the zero frame rectangle by specifying the following parameters in init:
 - mode: CalendarSeparatorLineMode - Line mode.

 # Code
 ```
 public func path(in rect: CGRect) -> Path
 ```
 */
@available(iOS 14.0.0, *)
struct CalendarLine: Shape {

    var mode: CalendarSeparatorLineMode = .solid

    public var body: some View {
        switch mode {
        case .solid:
            Rectangle()
                .frame(height: 1)
        case .dashed(let lineWidth, let dash):
            CalendarLine()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: [dash]))
                .frame(height: 1)
        }

    }

    public init() {}

    public init(mode: CalendarSeparatorLineMode) {
        self.mode = mode
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }

}
