//
//  TextOperationView.swift
//  AdmiralSwiftUI
//
//  Created on 13.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import SwiftUI
/**
 TextOperationView - the component that presents a rounded view with title, description and chatBubbleStatusView.

 You can create a TextOperationView with the zero frame rectangle by specifying the following parameters in init:
 ## Initializer parameters:

 - style: TextOperationViewStyle - The style of TextOperationView.
 - chatStatus: ChatStatus? - The status of ChatBubbleStatusView.
 - direction: ChatDirection - The direction of ChatBubbleStatusView.
 - time: String - A time of TextOperationView.
 - title: String - A title text of TextOperationView.
 - description: String - A description text of TextOperationView

 ## Example to create TextOperationView
 # Code
 ```
 TextOperationView(
 style: .success,
 chatStatus: .receive,
 direction: .left,
 time: "21:21",
 title: "+ 35 000 ₽",
 description: "НПО «Ромашка»"
 )
 ```
 */

public enum TextOperationViewStyle: Int {
    /// The success state of the TextOperationView.
    case success
    /// The error state of the TextOperationView.
    case error
    /// The default state of the TextOperationView.
    case `default`
}

@available(iOS 14.0.0, *)
/// A component that presents a rounded view with title, description and chatBubbleStatusView.
public struct TextOperationView: View {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = LayoutGrid.module * 29
        static let paddingHorizontal = LayoutGrid.tripleModule / 2
        static let paddingVertical = LayoutGrid.module
        static let cornerRadius = LayoutGrid.tripleModule / 2
    }

    // MARK: - Public properties

    /// The style of TextOperationView.
    @State public var style: TextOperationViewStyle

    /// The status of ChatBubbleStatusView.
    public var chatStatus: ChatStatus?

    /// The direction of ChatBubbleStatusView.
    public var direction: ChatDirection

    /// A time of TextOperationView.
    public var time: String

    /// A title text of TextOperationView.
    public var title: String

    /// A description text of TextOperationView.
    public var description: String

    /// Action error button.
    public var errorAction: () -> ()

    // MARK: - Private properties

    @ObservedObject private var schemeProvider: SchemeProvider<TextOperationViewScheme>

    // MARK: - Initializer

    public init(
        style: TextOperationViewStyle,
        chatStatus: ChatStatus?,
        direction: ChatDirection = .left,
        time: String,
        title: String,
        description: String,
        errorAction: @escaping () -> () = {},
        schemeProvider: SchemeProvider<TextOperationViewScheme> = AppThemeSchemeProvider<TextOperationViewScheme>()
    ) {
        self._style = .init(initialValue: style)
        self.chatStatus = chatStatus
        self.direction = direction
        self.time = time
        self.title = title
        self.description = description
        self.chatStatus = chatStatus
        self.direction = direction
        self.errorAction = errorAction
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        switch direction {
        case .left:
            HStack(spacing: .zero) {
                contentView(scheme)
                Spacer()
            }
            .eraseToAnyView()

        case .right:
            HStack(spacing: .zero) {
                Spacer()
                contentView(scheme)
            }
            .eraseToAnyView()
        }

    }

    // MARK: - Private methods

    private func contentView(_ scheme: TextOperationViewScheme) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: LayoutGrid.module) {
                VStack(alignment: .leading, spacing: LayoutGrid.module / 2) {
                    Text(title)
                        .font(scheme.titleFont.swiftUIFont)
                        .foregroundColor(scheme.titleColor.parameter(style: style)?.swiftUIColor)
                    Text(description)
                        .font(scheme.desciptionFont.swiftUIFont)
                        .foregroundColor(scheme.desciptionColor.swiftUIColor)
                }
                VStack(spacing: .zero) {
                    HStack(spacing: .zero) {
                        Text(time)
                            .foregroundColor(scheme.timeColor.swiftUIColor)
                            .font(scheme.timeFont.swiftUIFont)
                        Spacer()
                    }
                    HStack(spacing: .zero) {
                        Spacer()
                        ChatBubbleStatusView(time: time, status: chatStatus, direction: direction)
                    }
                }
            }
            .padding(.horizontal, Constants.paddingHorizontal)
            .padding(.vertical, Constants.paddingVertical)
            .background(scheme.backgroundColor.parameter(style: style)?.swiftUIColor)
            .clipShape(
                RoundedCorner(radius: Constants.cornerRadius, corners: [.allCorners])
            )
            .frame(width: Constants.width)
            statusError(scheme: scheme)
        }
    }
    
    private func statusError(scheme: TextOperationViewScheme) -> some View {
        return VStack {
            if chatStatus == .error && direction == .right {
                Image(uiImage: Asset.Service.Solid.errorSolid.image)
                    .resizable()
                    .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
                    .foregroundColor(scheme.errorImageColor.swiftUIColor)
                    .padding(.top, LayoutGrid.module)
                    .padding(.leading, LayoutGrid.module)
                    .onTapGesture {
                        errorAction()
                    }
            }
        }
    }
}

@available(iOS 14.0, *)
struct TextOperationView_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            TextOperationView(
                style: .default,
                chatStatus: .receive,
                direction: .left,
                time: "21:21",
                title: "+ 35 000 ₽",
                description: "НПО «Ромашка»"
            )
            TextOperationView(
                style: .success,
                chatStatus: .receive,
                direction: .left,
                time: "21:21",
                title: "+ 35 000 ₽",
                description: "НПО «Ромашка»"
            )
            TextOperationView(
                style: .error,
                chatStatus: .error,
                direction: .right,
                time: "21:21",
                title: "+ 35 000 ₽",
                description: "НПО «Ромашка»"
            )
        }
    }
}
