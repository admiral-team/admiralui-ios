//
//  SmallInformer.swift
//  AdmiralUIResources
//
//  Created on 24.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 SmallInformerArrowDirection - Public enum for direction SmallInformer
 
 SmallInformerArrowDirection can be one of the following values:
 - top - Top 
 - bottom - Cell with ArrowDown Image.
 - empty - Cell without image. There is an indent from the right edge.
 - none - Cell without image. The position of the cell is at the right edge.
 */
public enum SmallInformerArrowDirection {
    case top
    case bottom
}
/**
 SmallInformer - The component is in four status colors with different pop-up positions. Multiline (up to six lines), changes its width depending on the content, the maximum width of the component is 288 px.

 You can create a SmallInformer with the zero frame rectangle by specifying the following parameters in init:

 - title: String - Informer title text.
 - value: InformerStyleSwiftUI - The style of Informer.
 - arrowDirection: SmallInformerArrowDirection - The direction of informers arrow - top or down.
 - arrowOffset: CGFloat - Offest of arrow.
 - cornerRadius: CGFloat - The corner radius of SmallInformer.

 ## Example to create SmallInformer
 # Code
 ```
 SmallInformer(
     title: .constant("Text"),
     informerStyle: .default,
     arrowDirection: .top
 )
```
 */
@available(iOS 14.0, *)
public struct SmallInformer: View {

    // MARK: - Constants

    private enum Constants {
        static let labelEdgeInsets: EdgeInsets = EdgeInsets(
            top: LayoutGrid.module,
            leading: LayoutGrid.halfModule * 3,
            bottom: LayoutGrid.module,
            trailing: LayoutGrid.halfModule * 3
        )
        static let topArrowImage = PrivateAsset.Custom.Segment.arrowUp.image
        static let bottomArrowImage = PrivateAsset.Custom.Segment.arrowDown.image
        static let imageSize = CGSize(width: LayoutGrid.doubleModule, height: LayoutGrid.module)
        static let informerMaxWidth: CGFloat = 243.0
    }
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Private Properties
        
    private let title: String
    private let informerStyle: InformerStyleSwiftUI
    private let arrowDirection: SmallInformerArrowDirection
    private let arrowOffset: CGFloat
    private let cornerRadius: CGFloat

    @State private var scheme: SmallInformerScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SmallInformerScheme>()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated input number object.
    /// - Parameters:
    ///   - title: Informer title text.
    ///   - value: The style of Informer.
    ///   - arrowDirection: The direction of informers arrow - top or down.
    ///   - arrowOffset: Offest of arrow.
    ///   - cornerRadius: Corner radius.
    public init(
        title: String,
        informerStyle: InformerStyleSwiftUI = .default,
        arrowDirection: SmallInformerArrowDirection = .top,
        arrowOffset: CGFloat = LayoutGrid.halfModule * 3,
        cornerRadius: CornerRadius = .module
    ) {
        self.title = title
        self.informerStyle = informerStyle
        self.arrowDirection = arrowDirection
        self.arrowOffset = arrowOffset
        self.cornerRadius = cornerRadius.rawValue
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let titleFont = Font(scheme.titleLabelFont.uiFont)
        let titleColor = scheme.titleLabelTextColors.parameter(
                isEnabled: isEnabled,
            style: informerStyle)?.swiftUIColor
        
        let wrapViewColor = Color(
            scheme.wrapViewBackgroundColors.parameter(
                isEnabled: isEnabled,
                style: informerStyle)?.uiColor ?? .clear)
        
        VStack(alignment: .leading, spacing: .zero) {
            if arrowDirection == .top {
                Image(uiImage: Constants.topArrowImage)
                    .padding(.leading, arrowOffset)
                    .foregroundColor(wrapViewColor)
            }
            Text(title)
                .foregroundColor(titleColor)
                .font(titleFont)
                .lineLimit(6)
                .padding(Constants.labelEdgeInsets)
                .multilineTextAlignment(.leading)
                .background(wrapViewColor)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .frame(width: Constants.informerMaxWidth, alignment: .leading)
            if arrowDirection == .bottom {
                Image(uiImage: Constants.bottomArrowImage)
                    .padding(.leading, arrowOffset)
                    .foregroundColor(wrapViewColor)
            }
        }
    }
}
