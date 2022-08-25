//
//  DoubleSlider.swift
//  AdmiralSwiftUI
//
//  Created on 29.09.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
public struct DoubleSliderView: View {
    
    enum Constants {
        static let circleXOffset: CGFloat = 5.0
        static let circleWidth: CGFloat = 10.0
        static let circleHeight: CGFloat = 10.0
        static let circleLine: CGFloat = 10.0
        static let lineHeight: CGFloat = 2.0
    }
    
    // MARK: - Internal Properties

    @Binding var valueFrom: Double
    @Binding var valueTo: Double
    @State var minValue: Double = 0.0
    @State var maxValue: Double = 1.0
    @Binding var segmentSize: CGSize
    
    var gestureChange: () -> ()
    
    @Environment(\.isEnabled) var isEnabled
    
    // MARK: - Private Properties
    
    @State private var isFromLastTouch: Bool = true
    @State private var scheme: SliderScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SliderScheme>()
    
    // MARK: - Initializer
    
    public init(
        valueFrom: Binding<Double>,
        valueTo: Binding<Double>,
        minValue: Double = 0.0,
        maxValue: Double = 1.0,
        segmentSize: Binding<CGSize>,
        gestureChange: @escaping () -> ()) {
        self._valueFrom = valueFrom
        self._valueTo = valueTo
        self.gestureChange = gestureChange
        self._segmentSize = segmentSize
        guard maxValue > minValue else { return }
        
        self._minValue = .init(initialValue: minValue)
        self._maxValue = .init(initialValue: maxValue)
    }
    
    /// `Slider` view setup
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        var valFrom = CGFloat((min(max(Double(valueFrom), minValue), maxValue) - minValue) / (maxValue - minValue))
        var valTo = CGFloat((min(max(Double(valueTo), minValue), maxValue) - minValue) / (maxValue - minValue))
        if valueFrom > valueTo {
            valFrom = valTo
        }
        if valueTo < valueFrom {
            valTo = valFrom
        }
        let thumbBorderColor = scheme.thumbBorderColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        let backgroundColor = scheme.backgroundColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        let thumbColor = scheme.thumbColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        
        return GeometryReader { geometry in
            ZStack (alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                defaultLine(backgroundColor: backgroundColor)
                accentLine(
                    fromVal: valFrom,
                    val: valTo - valFrom,
                    width: geometry.size.width,
                    thumbBorderColor: thumbBorderColor)
                circleFromView(
                    val: valFrom,
                    width: geometry.size.width,
                    thumbColor: thumbColor,
                    thumbBorderColor: thumbBorderColor)
                    .zIndex(isFromLastTouch ? 1.0 : 0.0)
                circleToView(
                    val: valTo,
                    width: geometry.size.width,
                    thumbColor: thumbColor,
                    thumbBorderColor: thumbBorderColor)
            })
        }
    }
    
    // MARK: - Private Methods
    
    private func accentLine(fromVal: CGFloat, val: CGFloat, width: CGFloat, thumbBorderColor: Color) -> some View {
        Capsule()
            .fill(thumbBorderColor)
            .offset(x: fromVal * (width - Constants.circleWidth - Constants.circleLine))
            .frame(height: Constants.lineHeight * 2)
            .frame(width: (val) * (width - Constants.circleWidth - Constants.circleLine) + LayoutGrid.halfModule)
    }
    
    private func defaultLine(backgroundColor: Color) -> some View {
        Capsule()
            .fill(backgroundColor)
            .frame(height: Constants.lineHeight)
            .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
    }
    
    private func circleView(val: CGFloat, width: CGFloat, thumbColor: Color, thumbBorderColor: Color) -> some View {
        Circle()
            .fill(thumbColor)
            .frame(width: Constants.circleWidth, height: Constants.circleHeight)
            .background(Circle().stroke(thumbBorderColor, lineWidth: Constants.circleLine))
            .offset(x: val * (width - Constants.circleWidth - Constants.circleLine) + Constants.circleXOffset)
            .gesture(DragGesture().onChanged({ (value) in
                isFromLastTouch = true
                gestureChange()
                
                let max = width - Constants.circleWidth - Constants.circleLine
                var curentValue: Double = minValue
                if value.location.x <= 0 {
                    curentValue = 0
                } else {
                    curentValue = Double(min(value.location.x, max))
                }
                let intValue = Int((curentValue / Double(max)) * (maxValue - minValue) + minValue)
                if valueTo >= Double(intValue) {
                    self.valueFrom = Double(intValue)
                } else {
                    self.valueFrom = valueTo
                }
            }))
    }
    
    private func circleFromView(val: CGFloat, width: CGFloat, thumbColor: Color, thumbBorderColor: Color) -> some View {
        Circle()
            .fill(thumbColor)
            .frame(width: Constants.circleWidth, height: Constants.circleHeight)
            .background(Circle().stroke(thumbBorderColor, lineWidth: Constants.circleLine))
            .offset(x: val * (width - Constants.circleWidth - Constants.circleLine) + Constants.circleXOffset)
            .gesture(DragGesture().onChanged({ (value) in
                isFromLastTouch = true
                gestureChange()
                
                let max = width - Constants.circleWidth - Constants.circleLine
                var curentValue: Double = minValue
                if value.location.x <= 0 {
                    curentValue = 0
                } else {
                    curentValue = Double(min(value.location.x, max))
                }
                let intValue = Int((curentValue / Double(max)) * (maxValue - minValue) + minValue)
                if valueTo >= Double(intValue) {
                    self.valueFrom = Double(intValue)
                } else {
                    self.valueFrom = valueTo
                }
            }))
    }
    
    private func circleToView(val: CGFloat, width: CGFloat, thumbColor: Color, thumbBorderColor: Color) -> some View {
        Circle()
            .fill(thumbColor)
            .frame(width: Constants.circleWidth, height: Constants.circleHeight)
            .background(Circle().stroke(thumbBorderColor, lineWidth: Constants.circleLine))
            .offset(x: val * (width - Constants.circleWidth - Constants.circleLine) + Constants.circleXOffset)
            .gesture(DragGesture().onChanged({ (value) in
                isFromLastTouch = false
                gestureChange()
                
                let max = width - Constants.circleWidth - Constants.circleLine
                var curentValue: Double = minValue
                if value.location.x <= 0 {
                    curentValue = 0
                } else {
                    curentValue = Double(min(value.location.x, max))
                }
                let intValue = Int((curentValue / Double(max)) * (maxValue - minValue) + minValue)
                if valueFrom <= Double(intValue) {
                    self.valueTo = Double(intValue)
                } else {
                    self.valueTo = valueFrom
                }
            }))
    }
    
    
}

