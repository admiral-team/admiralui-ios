//
//  ActivityIndicator.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
import SwiftUI

/**
 ActivityIndicator - A view that shows that a task is in progress.

 You can create a ActivityIndicator by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - style: Style - Activity indicator style
 - size: Size - Activity indicator size. Can be: small, medium, large
 
 You can control the animation time using the animatableParameter parameter
 
 ## Example to create ActivityIndicator with different parameters:
 # Code
 ```
 ActivityIndicator(style: .default, size: .small)
 ```
*/
@available(iOS 14.0, *)
public struct ActivityIndicator: View {
    
    enum Constants {
        static let duration = 2.0
    }
    
    /// Activity indicator style.
    public enum Style {
        /// Default style.
        case `default`
        /// Contrast content style.
        case contrast
    }
    
    /// Activity indicator size.
    public enum Size: Int {
        /// Small size.
        case small
        /// Medium size.
        case medium
        /// Large size.
        case large
    }
    
    // MARK: - Public Properties
    
    /// The control style.
    public var style: Style = .default
    
    /// The control size.
    public var size: Size = .large
    
    // MARK: - Private Properties
    
    @Environment(\.isEnabled) private var isEnabled
    
    @State private var scheme: ActivityIndicatorScheme? = nil
    @State private var animatableParameter: Double = 0
    @ObservedObject var schemeProvider: SchemeProvider<ActivityIndicatorScheme>
    
    // MARK: - Initializer
    
    public init(
        style: Style = .default,
        size: Size = .medium,
        schemeProvider: SchemeProvider<ActivityIndicatorScheme> = AppThemeSchemeProvider<ActivityIndicatorScheme>()
    ) {
        self.style = style
        self.size = size
        self.schemeProvider = schemeProvider
    }

    public var body: some View {
        let animation = Animation
            .easeIn(duration: Constants.duration)
            .repeatForever(autoreverses: false)
        let scheme = self.scheme ?? schemeProvider.scheme
        var backroundColor: Color
        var sizeItem: CGSize
        var lineWidth: CGFloat
        
        switch style {
        case .default:
            backroundColor = scheme.backgroundDefaultColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        case .contrast:
            backroundColor = scheme.backgroundConstrastColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear
        }

        switch size {
        case .small:
            sizeItem = CGSize(width: LayoutGrid.doubleModule, height: LayoutGrid.doubleModule)
            lineWidth = LayoutGrid.doubleModule / 8
        case .medium:
            sizeItem = CGSize(width: LayoutGrid.tripleModule, height: LayoutGrid.tripleModule)
            lineWidth = LayoutGrid.tripleModule / 8
        case .large:
            sizeItem = CGSize(width: LayoutGrid.doubleModule * 3, height:LayoutGrid.doubleModule * 3)
            lineWidth = LayoutGrid.module / 2
        }

        return GrowingActivityIndicator(p: animatableParameter)
            .stroke(backroundColor, lineWidth: lineWidth)
            .frame(width: sizeItem.width, height: sizeItem.height)
            .onAppear {
                self.animatableParameter = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation(animation) {
                        self.animatableParameter = 1
                    }
                }
            }
    }

}

@available(iOS 14.0, *)
struct GrowingActivityIndicator: Shape {

    var maxLength = 2 * Double.pi - 0.7
    var lag = 0.35
    var p: Double

    var animatableData: Double {
        get { return p }
        set { p = newValue }
    }

    func path(in rect: CGRect) -> Path {

        let h = p * 2
        var length = h * maxLength
        if h > 1 && h < lag + 1 {
            length = maxLength
        }
        if h > lag + 1 {
            let coeff = 1 / (1 - lag)
            let n = h - 1 - lag
            length = (1 - n * coeff) * maxLength
        }

        let first = Double.pi / 2
        let second = 4 * Double.pi - first

        var end = h * first
        if h > 1 {
            end = first + (h - 1) * second
        }

        let start = end + length

        var p = Path()
        p.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
                 radius: rect.size.width/2,
                 startAngle: Angle(radians: start),
                 endAngle: Angle(radians: end),
                 clockwise: true)
        return p
    }
}

@available(iOS 14.0, *)
struct GrowingArc_Previews: PreviewProvider {
    
    static var previews: some View {
        ActivityIndicator()
            .frame(width: 24.0, height: 24.0)
    }
}

