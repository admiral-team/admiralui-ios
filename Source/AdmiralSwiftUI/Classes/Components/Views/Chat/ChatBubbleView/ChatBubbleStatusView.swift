//
//  ChatBubbleStatusView.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/// The style .
public enum ChatBubbleStatusStyle: Int {
    /// Sets default style of fonts and colors.
    case `default`
    /// Sets light style of fonts and colors.
    case light
}
/**
 ChatBubbleStatusView - A view for chat message with time.

 You can create a ChatBubbleStatusView by specifying the following parameters in the initializer
 - time: String - Time text message. It located in the bottom right edge. The supported format of time is HH:mm
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

    /// The time. It located in the bottom right edge. The supported format of time is HH:mm
    @State public var time: String

    /// The status of message. It controls the image type. It can be -  case loading, error, sent, receive, read and none
    @State public var status: ChatStatus?

    /// The value that used in visal scheme to control foreground color of image. It can be left or right
    @State public var direction: ChatDirection

    /// The value that used in visal scheme to control foreground color of image and text. It can be light or default.
    @State public var style: ChatBubbleStatusStyle

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<ChatBubbleStatusViewScheme>

    // MARK: - Initializer

    public init(
        time: String,
        status: ChatStatus? = nil,
        direction: ChatDirection,
        style: ChatBubbleStatusStyle = .default,
        schemeProvider: SchemeProvider<ChatBubbleStatusViewScheme> = AppThemeSchemeProvider<ChatBubbleStatusViewScheme>()
    ) {
        self._time = .init(initialValue: time)
        self._status = .init(initialValue: status)
        self._direction = .init(initialValue: direction)
        self._style = .init(initialValue: style)
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        var image: Image?
        switch status {
        case .loading:
            image = SymbolAssets.System.Outline.time.swiftUIImage
        case .sent:
            image = Image(uiImage: ImageAssets.Custom.Chat.sent.image)
        case .receive:
            image = Image(uiImage: ImageAssets.Custom.Chat.sent.image)
        case .read:
            image = Image(uiImage: ImageAssets.Custom.Chat.read.image)
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
