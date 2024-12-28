//
//  ShimmerView.swift
//  AdmiralSwiftUI
//
//  Created on 25.06.2021.
//
import SwiftUI
/**
 ShimmerModifier -  modifier for set shimmer view.
 You can create a ShimmerModifier with the zero frame rectangle by specifying the following parameters in init:
 - isActive: Bool - the active flag of ShimmerModifier
 - cornerRadius: CGFloat - The corner radius of ShimmerModifier
 ## Example to create ShimmerModifier
 # Code
 ```
 HStack {
 }.modifier(ShimmerModifier(isActive: true, cornerRadius: 12))
 ```
 */
/// Shimmer modifier for set shimmer view.
@available(iOS 14.0.0, *)
public struct ShimmerModifier: ViewModifier {

    // MARK: - Private Properties

    private let isActive: Bool
    private let cornerRadius: CGFloat

    // MARK: - Initializer

    public init(isActive: Bool, cornerRadius: CGFloat) {
        self.isActive = isActive
        self.cornerRadius = cornerRadius
    }

    // MARK: - Body

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
struct ShimmerView: View {
    // MARK: - Private Properties

    @EnvironmentObject private var shimmerConfig: ShimmerConfig
    @State private var shimmerOffset: CGFloat = -UIScreen.main.bounds.width

    // MARK: - Body

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
                    .offset(x: shimmerOffset, y: 0)
                    .transition(.move(edge: .leading))
            }
            .onAppear {
                startShimmerAnimation(for: geometry.size.width)
            }
        }
    }

    // MARK: - Private Methods

    private func startShimmerAnimation(for width: CGFloat) {
        shimmerOffset = -width
        withAnimation(Animation.linear(duration: self.shimmerConfig.shimmerDuration).repeatForever(autoreverses: false)) {
            shimmerOffset = width
        }
    }
}

@available(iOS 14.0, *)
struct ShimmerPreviews: PreviewProvider {
    static var previews: some View {
        ShimmerView()
    }
}
