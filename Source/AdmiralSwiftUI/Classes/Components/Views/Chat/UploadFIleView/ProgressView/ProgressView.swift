//
//  ProgressView.swift
//  AdmiralUIResources
//
//  Created on 02.11.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

@available(iOS 14.0.0, *)
public enum ProgressViewStyle: Int {
    case `default`
    case accent
    case staticWhite
}

@available(iOS 14.0.0, *)
public enum ProgressViewSize {
    case small
    case large
    case medium
}

/**
 ProgressView - the component that used for showing view with center loading indicator.

 You can create a ProgressView with the zero frame rectangle by specifying the following parameters in init:

 - style: ProgressViewStyle - The style of progress spinner.
 - progressViewSize: ProgressViewSize - the size for progress spinner.

 ## Example to create ProgressView
 # Code
 ```
 public var body: some View {
    ProgressView(
        style: .accent
    )
 }
```
 */
/// A view with progress bar, spinner
@available(iOS 14.0.0, *)
public struct ProgressView: View {

    // MARK: - Constants

    private enum Constants {
        static let progressRotationAngle: Double = 360
        static let closeImageWidth: CGFloat = LayoutGrid.module + 6
        static let closeImageHeight: CGFloat = LayoutGrid.module + 6
        static let circleOpacity: Double = 0.4

        static let progressFrameSmall: CGFloat = LayoutGrid.quadrupleModule + 2
        static let progressFrameLarge: CGFloat = LayoutGrid.quadrupleModule + 10
        static let progressFrameMedium: CGFloat = LayoutGrid.halfModule * 9

        static let circleLineWidthSmall: CGFloat = 1.0
        static let circleLineWidthLarge: CGFloat = 4.0
        static let circleLineWidthMedium: CGFloat = 2.0

        static let circleFrameSize: Double = 40
        static let animationDuration: Double = 1.0
    }

    // MARK: - Public properties

    /// The style of progress spinner.
    public let style: ProgressViewStyle

    /// Kind of size for progress spinner.
    public let progressViewSize: ProgressViewSize

    // MARK: - Private properties

    private var closeAction: () -> ()
    @State private var animate: Bool = false

    @State private var scheme: ProgressViewScheme? = nil
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ProgressViewScheme>()

    // MARK: - Computed properties

    private var circleLineWidth: CGFloat {
        switch progressViewSize {
        case .small:
            return Constants.circleLineWidthSmall
        case .large:
            return Constants.circleLineWidthLarge
        case .medium:
            return Constants.circleLineWidthMedium
        }
    }

    private var progressFrame: (CGFloat, CGFloat) {
        switch progressViewSize {
        case .small:
            return (Constants.progressFrameSmall, Constants.progressFrameSmall)
        case .large:
            return (Constants.progressFrameLarge, Constants.progressFrameLarge)
        case .medium:
            return (Constants.progressFrameMedium, Constants.progressFrameMedium)
        }
    }

    // MARK: - Init/deinit

    public init(
        style: ProgressViewStyle = .default,
        progressViewSize: ProgressViewSize = .medium,
        closeAction: @escaping () -> () = {}
    ) {
        self.style = style
        self.progressViewSize = progressViewSize
        self.closeAction = closeAction
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = scheme ?? schemeProvider.scheme
        ZStack {
            Circle()
                .trim(from: 0, to: 1.0)
                .stroke(
                    gradient(scheme: scheme)
                    , style: StrokeStyle(
                        lineWidth: circleLineWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: progressFrame.0, height: progressFrame.1)
                .rotationEffect(
                    .init(degrees: animate ? Constants.progressRotationAngle : 0)
                )
                .animation(
                    Animation.linear(duration: Constants.animationDuration)
                        .repeatForever(autoreverses: false)
                )
            Image(uiImage: Asset.Service.Outline.closeOutline.image)
                .foregroundColor(scheme.iconColor.parameter(style: style)?.swiftUIColor)
                .frame(
                    width: Constants.closeImageWidth,
                    height: Constants.closeImageHeight
                )
                .onTapGesture { closeAction() }
        }
        .onAppear() { animate.toggle() }
    }

    private func gradient(scheme: ProgressViewScheme) -> AngularGradient {
        guard let circleColor = scheme.circleColor.parameter(style: style) else {
            return AngularGradient(gradient: .init(colors: [Color.white]),center: .center)
        }
        
        return AngularGradient(
            gradient: .init(
                colors: [
                    circleColor.swiftUIColor.opacity(Constants.circleOpacity),
                    circleColor.swiftUIColor
                ]
            ),
            center: .center
        )
    }

}

@available(iOS 14.0, *)
struct ProgressView_Previews: PreviewProvider {

    static var previews: some View {
        ProgressView(
            style: .accent
        )
        ProgressView(
            style: .default
        )
    }

}
