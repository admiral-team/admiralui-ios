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
 - top - The arrow is at the top
 - bottom - The arrow is at the bottom
 - topRight - The arrow is at the top right
 - bottomRight - The arrow is at the bottom right
 
 By default SmallInformerArrowDirection is .top
 */
public enum SmallInformerArrowDirection {
    /// The arrow is at the top
    case top
    /// The arrow is at the bottom
    case bottom
    /// The arrow is at the top right
    case topRight
    /// The arrow is at the bottom right
    case bottomRight
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
        static let informerMaxWidth: CGFloat = LayoutGrid.quadrupleModule * 9
    }
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Private Properties
    
    private let title: String
    private let informerStyle: InformerStyleSwiftUI
    private let arrowDirection: SmallInformerArrowDirection
    private let arrowOffset: CGFloat
    private let cornerRadius: CGFloat
    private var arrowImage: Image {
        return Image(uiImage: arrowDirection == .top || arrowDirection == .topRight ? Constants.topArrowImage : Constants.bottomArrowImage)
    }
    private var arrowHorizontalOffcet: CGFloat {
        return arrowDirection == .top || arrowDirection == .topRight ? -LayoutGrid.module : LayoutGrid.module
    }
    
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
        
            Text(title)
                .foregroundColor(titleColor)
                .font(titleFont)
                .lineLimit(6)
                .padding(Constants.labelEdgeInsets)
                .multilineTextAlignment(.leading)
                .background(wrapViewColor)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(
                    arrowImage
                        .offset(y: arrowHorizontalOffcet)
                        .padding(arrowDirection == .top || arrowDirection == .bottom ? .leading : .trailing, arrowOffset)
                        .foregroundColor(wrapViewColor),
                    alignment: arrowAlignment())
                .frame(width: Constants.informerMaxWidth, alignment: .leading)
    }
    
    // MARK: - Private Methods
    
    private func arrowAlignment() -> Alignment {
        switch arrowDirection {
        case .top:
            return .topLeading
        case .topRight:
            return .topTrailing
        case .bottom:
            return .bottomLeading
        case .bottomRight:
            return .bottomTrailing
        }
    }
    

}

@available(iOS 14.0, *)
struct SmallInformerPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack{
                SmallInformer(title: "Text Informer", informerStyle: .default, arrowDirection: .topRight)
                Spacer()
            }
            Spacer()
        }
    }
}
