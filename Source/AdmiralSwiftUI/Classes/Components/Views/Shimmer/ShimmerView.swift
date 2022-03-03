//
//  ShimmerView.swift
//  AdmiralSwiftUI
//
//  Created on 25.06.2021.
//

import SwiftUI

/// Shimmer modifier for set shimmer view.
@available(iOS 14.0.0, *)
public struct ShimmerModifier: ViewModifier {
    let isActive: Bool
    var cornerRadius: CGFloat
    
    init(isActive: Bool, cornerRadius: CGFloat) {
        self.isActive = isActive
        self.cornerRadius = cornerRadius
    }
    
    public func body(content: Content) -> Self.Body {
        guard isActive else { return AnyView(content) }
        return AnyView(
            content.overlay(
                ShimmerView()
                    .clipped()
                    .cornerRadius(cornerRadius)
            )
        )
    }
    
    public typealias Body = AnyView
}

@available(iOS 14.0.0, *)
extension View {
    
    public dynamic func shimmer(isActive: Bool, cornerRadius: CGFloat = LayoutGrid.halfModule) -> some View {
        self.modifier(ShimmerModifier(isActive: isActive, cornerRadius: cornerRadius))
    }
    
}

/**
 ShimmerView - An element that displays the loading of a row, an element, or an entire block. In the library, the component is presented in three versions, the desired size can be set independently.

 ## Example to create ShimmerView
 # Code
 ```
 ShimmerView()
```
 */
@available(iOS 14.0.0, *)
struct ShimmerView : View {
    
    @EnvironmentObject private var shimmerConfig: ShimmerConfig
        
    var body: some View {
        let startGradient = Gradient.Stop(color: self.shimmerConfig.bgColor, location: 0.3)
        let endGradient = Gradient.Stop(color: self.shimmerConfig.bgColor, location: 0.7)
        let maskGradient = Gradient.Stop(color: self.shimmerConfig.shimmerColor, location: 0.5)
        
        let gradient = Gradient(stops: [startGradient, maskGradient, endGradient])
        
        let linearGradient = LinearGradient(gradient: gradient,
                                            startPoint: .leading,
                                            endPoint: .trailing)
            
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .background(self.shimmerConfig.bgColor)
                    .foregroundColor(.clear)
                Rectangle()
                    .foregroundColor(.clear)
                    .background(linearGradient)
                    .rotationEffect(Angle(degrees: self.shimmerConfig.shimmerAngle))
                    .offset(x: self.shimmerConfig.isActive ? self.shimmerOffset(geometry.size.width) : -self.shimmerOffset(geometry.size.width), y: 0)
                    .transition(.move(edge: .leading))
                    .animation(.linear(duration: self.shimmerConfig.shimmerDuration))
            }
            .padding(EdgeInsets(top: -self.shimmerOffset(geometry.size.width),
                                leading: 0,
                                bottom: -self.shimmerOffset(geometry.size.width),
                                trailing: 0))
        }
    }
    
    func shimmerOffset(_ width: CGFloat) -> CGFloat {
        width + CGFloat(2 * self.shimmerConfig.shimmerAngle)
    }
}

@available(iOS 14.0, *)
struct ShimmerPreviews: PreviewProvider {
    static var previews: some View {
        ShimmerView()
    }
}
