//
//  Slider.swift
//  AdmiralSwiftUI
//
//  Created on 27.05.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
public struct SliderView: View {

    // MARK: - Constants

    enum Constants {
        static let circleXOffset: CGFloat = 5.0
        static let circleWidth: CGFloat = 10.0
        static let circleHeight: CGFloat = 10.0
        static let circleLine: CGFloat = 10.0
        static let lineHeight: CGFloat = 2.0
    }
    
    // MARK: - Internal Properties

    @Binding var value: Double
    @State var minValue: Double = 0.0
    @State var maxValue: Double = 1.0
    
    var gestureChange: () -> ()
    
    @Environment(\.isEnabled) var isEnabled
    
    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<SliderScheme>
    
    // MARK: - Initializer
    
    public init(
        value: Binding<Double>,
        minValue: Double = 0.0,
        maxValue: Double = 1.0,
        schemeProvider: SchemeProvider<SliderScheme> = AppThemeSchemeProvider<SliderScheme>(),
        gestureChange: @escaping () -> ()
    ) {
        self._value = value
        self.schemeProvider = schemeProvider
        self.gestureChange = gestureChange
        guard maxValue > minValue else { return }
        
        self._minValue = .init(initialValue: minValue)
        self._maxValue = .init(initialValue: maxValue)
    }

    // MARK: - Body

    /// `Slider` view setup
    public var body: some View {
        let scheme = schemeProvider.scheme
        let val = CGFloat((min(max(Double(value), minValue), maxValue) - minValue) / (maxValue - minValue))
        let thumbBorderColor = scheme.thumbBorderColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        let backgroundColor = scheme.backgroundColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        let thumbColor = scheme.thumbColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        
        GeometryReader { geometry in
            ZStack (alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                defaultLine(backgroundColor: backgroundColor)
                accentLine(
                    val: val,
                    width: geometry.size.width,
                    thumbBorderColor: thumbBorderColor)
                circleView(
                    val: val,
                    width: geometry.size.width,
                    thumbColor: thumbColor,
                    thumbBorderColor: thumbBorderColor)
            })
        }
    }
    
    // MARK: - Private Methods
    
    private func accentLine(val: CGFloat, width: CGFloat, thumbBorderColor: Color) -> some View {
        Capsule()
            .fill(thumbBorderColor)
            .frame(height: Constants.lineHeight * 2)
            .frame(width: (val) * (width - Constants.circleWidth - Constants.circleLine) + LayoutGrid.halfModule)
    }
    
    private func defaultLine(backgroundColor: Color) -> some View {
        Capsule()
            .fill(backgroundColor)
            .frame(height: Constants.lineHeight)
    }
    
    private func circleView(val: CGFloat, width: CGFloat, thumbColor: Color, thumbBorderColor: Color) -> some View {
        Circle()
            .fill(thumbColor)
            .frame(width: Constants.circleWidth, height: Constants.circleHeight)
            .background(Circle().stroke(thumbBorderColor, lineWidth: Constants.circleLine))
            .offset(x: val * (width - Constants.circleWidth - Constants.circleLine) + Constants.circleXOffset)
            .gesture(DragGesture().onChanged({ (value) in
                gestureChange()
                
                let max = width - Constants.circleWidth - Constants.circleLine
                var curentValue: Double = minValue
                if value.location.x <= 0 {
                    curentValue = 0
                } else {
                    curentValue = Double(min(value.location.x, max))
                }
                let intValue = Int((curentValue / Double(max)) * (maxValue - minValue) + minValue)
                self.value = Double(intValue)
            }))
    }
    
    
}
