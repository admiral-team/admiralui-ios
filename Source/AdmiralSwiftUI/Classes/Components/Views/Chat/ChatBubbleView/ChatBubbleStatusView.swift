//
//  ChatBubbleStatusView.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/// The style of ChatBubbleStatusView.
public enum ChatBubbleStatusStyle: Int {
    /// The default style of ChatBubbleStatusView.
    case `default`
    /// The light style of ChatBubbleStatusView.
    case light
}
/**
 ChatBubbleStatusView - A view for chat message with time.

 You can create a ChatBubbleStatusView by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - time: String - Time text message
 - status: ChatStatus - A status ChatBubbleView. Can be in the following states: loading, error, sent, receive, read
 - direction: ChatDirection - A direction for text mesage. Can be: left, right
 - time: String - Time text message.
 - style: ChatBubbleStatusStyle - The style ChatBubbleStatusView
 
 ## Example to create ChatBubbleStatusView:
 # Code
 ```
 ChatBubbleStatusView(
            time: "12:34",
            status: .receive,
            direction: .left)
 ```
*/
@available(iOS 14.0, *)
public struct ChatBubbleStatusView: View {
    
    // MARK: - Public Properties

    /// The time of ChatBubbleStatusView
    @State public var time: String

    /// The status of ChatBubbleStatusView
    @State public var status: ChatStatus?

    /// The direction of ChatBubbleStatusView
    @State public var direction: ChatDirection

    /// The style of ChatBubbleStatusView
    @State public var style: ChatBubbleStatusStyle

    // MARK: - Private Properties
    
    @Binding private var scheme: ChatBubbleStatusViewScheme?
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ChatBubbleStatusViewScheme>()
    
    // MARK: - Initializer

    public init(
        time: String,
        status: ChatStatus? = nil,
        direction: ChatDirection,
        style: ChatBubbleStatusStyle = .default,
        scheme: Binding<ChatBubbleStatusViewScheme?> = .constant(nil)
    ) {
        self._time = .init(initialValue: time)
        self._status = .init(initialValue: status)
        self._direction = .init(initialValue: direction)
        self._style = .init(initialValue: style)
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        var image: Image?
        switch status {
        case .loading:
            image = AssetSymbol.System.Outline.time.image
        case .sent:
            image = Image(uiImage: PrivateAsset.Custom.Chat.sent.image)
        case .receive:
            image = Image(uiImage: PrivateAsset.Custom.Chat.sent.image)
        case .read:
            image = Image(uiImage: PrivateAsset.Custom.Chat.read.image)
        default:
            image = nil
        }
        return HStack(spacing: LayoutGrid.halfModule) {
            Text(time)
                .foregroundColor(scheme.textColor.parameter(for: status ?? .loading, direction: direction, style: style)?.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
            if let image = image, let status = status {
                image
                    .resizable()
                    .frame(width: LayoutGrid.doubleModule, height: LayoutGrid.doubleModule)
                    .foregroundColor(scheme.imageColor.parameter(for: status, direction: direction, style: style)?.swiftUIColor)
            }
        }
        .fixedSize()
    }
    
}

@available(iOS 14.0, *)
struct ChatBubbleStatusView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ChatBubbleStatusView(time: "12:34", status: .receive, direction: .left)
            ChatBubbleStatusView(time: "12:34", status: .error, direction: .right)
        }
    }
}
