//
//  ChatBubbleView.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 ChatStatus - Public enum for status ChatBubbleView
 
 ChatStatus can be one of the following values:
 - loading
 - error
 - sent
 - receive
 - read
 */
public enum ChatStatus: String {
    case loading
    case error
    case sent
    case receive
    case read
    case none
}

/**
 ChatDirection - Public enum for dirction ChatBubbleView
 
 ChatDirection can be one of the following values:
 - right
 - left
 */
public enum ChatDirection: String {
    case left
    case right
}

/**
 ChatBubbleView - A view for chat message.

 You can create a ChatBubbleView by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - text: String - Text message.
 - direction: ChatDirection - A direction for text mesage. Can be: left, right
 - time: String - Time text message.
 - status: ChatStatus - A status ChatBubbleView. Can be in the following states: loading, error, sent, receive, read
 - name: String - Name text on up message.
 - isRoundAllCorners: Bool - Flag for round all corners.
 
 ## Example to create ChatBubbleView:
 # Code
 ```
 ChatBubbleView(
        text: "Hi, Andrey",
        direction: .left,
        time: "12:34",
        status: .error,
        name: "Антон")
 ```
*/
@available(iOS 14.0, *)
public struct ChatBubbleView: View {

    private enum Constants {
        static let minWidth: CGFloat = LayoutGrid.quadrupleModule * 3
        static let ratioWidth: CGFloat = 0.2
    }

    // MARK: - Public Properties
    
    /// Text message.
    public let text: String
    
    /// Direction message.
    public var direction: ChatDirection
    
    /// Time text message.
    public var time: String
    
    /// Status message.
    public var status: ChatStatus?
    
    /// Name text on up message.
    public var name: String?
    
    /// Flag for round all corners.
    public var isRoundAllCorners: Bool = false

    /// Max width message view.
    public let maxWidth: CGFloat?
    
    /// Action error button.
    private var errorAction: () -> ()
    
    // MARK: - Private Properties

    private var segmentSizeWidth: CGFloat {
        segmentSize.width == 0.0 ? Constants.minWidth : segmentSize.width
    }

    @State private var segmentSize: CGSize = .zero
    
    @State private var scheme: ChatBubbleViewScheme? = nil
    @ObservedObject var schemeProvider = SwiftUISchemeProvider<ChatBubbleViewScheme>()
    
    // MARK: - Initializer

    public init(
        text: String,
        direction: ChatDirection,
        time: String,
        status: ChatStatus? = nil,
        name: String? = nil,
        isRoundAllCorners: Bool = false,
        maxWidth: CGFloat? = nil,
        errorAction: @escaping ()->() = {}) {
        self.text = text
        self.direction = direction
        self.time = time
        self.status = status
        self.name = name
        self.isRoundAllCorners = isRoundAllCorners
        self.maxWidth = maxWidth
        self.errorAction = errorAction
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        switch direction {
        case .left:
            return HStack(spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    if let name = name {
                        HStack(spacing: .zero) {
                            Text(name)
                                .font(scheme.nameTextFont.swiftUIFont)
                                .foregroundColor(scheme.nameTextColor.swiftUIColor)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: LayoutGrid.halfModule)
                    }
                    HStack {
                        contentView(scheme: scheme)
                            .clipShape(
                                RoundedCorner(radius: isRoundAllCorners ? LayoutGrid.halfModule * 3 : LayoutGrid.halfModule / 2, corners: [.bottomLeft])
                            )
                            .clipShape(
                                RoundedCorner(radius: LayoutGrid.halfModule * 3, corners: [.topRight, .topLeft, .bottomRight])
                            )
                    }
                    .frame(maxWidth: maxWidth ?? segmentSizeWidth, alignment: .leading)
                }
                Spacer(minLength: spacerMinLength)
            }
            .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
            .eraseToAnyView()
        case .right:
            return HStack(spacing: .zero) {
                Spacer(minLength: spacerMinLength)
                HStack(alignment: .bottom, spacing: 0) {
                    contentView(scheme: scheme)
                        .clipShape(
                            RoundedCorner(radius:  isRoundAllCorners ? LayoutGrid.halfModule * 3 : LayoutGrid.halfModule / 2, corners: [.bottomRight])
                        )
                        .clipShape(
                            RoundedCorner(radius: LayoutGrid.halfModule * 3, corners: [.topRight, .topLeft, .bottomLeft])
                        )
                    if status == .error {
                        errorImage
                    }
                }
                .frame(maxWidth: maxWidth ?? segmentSizeWidth, alignment: .trailing)
            }
            .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
            .eraseToAnyView()
        }
    }
    
    // MARK: - Private Methods
    
    private func contentView(scheme: ChatBubbleViewScheme) -> some View {
        VStack(alignment: .trailing, spacing: LayoutGrid.module) {
            HStack {
                Text(text)
                    .foregroundColor(scheme.textColor.parameter(for: direction)?.swiftUIColor)
                    .font(scheme.textFont.swiftUIFont)
            }
            .padding(.top, LayoutGrid.module)
            .padding(.bottom, LayoutGrid.halfModule)
            ChatBubbleStatusView(time: time, status: status, direction: direction)
                .padding(.bottom, LayoutGrid.module)
        }
        .padding(.horizontal, LayoutGrid.halfModule * 3)
        .background(scheme.backgroundColor.parameter(for: direction)?.swiftUIColor)
    }
    
    private var errorImage: some View {
        return Image(uiImage: PrivateAsset.Custom.Chat.error.image)
            .padding(.top, LayoutGrid.module)
            .frame(width: LayoutGrid.module * 5, height: LayoutGrid.module * 5)
            .onTapGesture {
                errorAction()
            }
    }

    private var spacerMinLength: CGFloat? {
        if maxWidth != nil {
            return nil
        } else if status == .error && direction == .right {
            return Constants.ratioWidth * (segmentSize.width - LayoutGrid.module * 5)
        } else {
            return Constants.ratioWidth * segmentSize.width
        }
    }
    
}

@available(iOS 14.0, *)
struct ChatBubbleView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ChatBubbleView(text: "Hi, Andrey", direction: .left, time: "12:34", status: .error, name: "Антон")
            ChatBubbleView(text: "Hi, Andrey", direction: .right, time: "12:34", status: .error, name: "Антон")
        }
    }
}
