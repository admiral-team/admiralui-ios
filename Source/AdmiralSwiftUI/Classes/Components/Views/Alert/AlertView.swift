//
//  AlertView.swift
//  AdmiralSwiftUI
//
//  Created on 10.01.2022.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/// Type size image from alert view.
public enum AlertViewImageType {
    case illustration
    case icon
}

/// Font style of tittle label from alert view.
public enum AlertTitleFontStyle: Int {
    case title1
    case title2
    case subtitle1
    case subtitle2
    case headLine
}

/// Font style of message label from alert view.
public enum AlertMessageFontStyle: Int {
    case body1
    case body2
    case subhead4
    case subhead3
}

/// Text color for labels from alert view.
public enum AlertColorStyle: Int {
    case additional
    case mask
    case primary
    case secondary
}

/**
 AlertView - the component that presents a warning message to the user with diffrent options.
 
 You can create a AlertView with the zero frame rectangle by specifying the following parameters in init:
 ## Initializer parameters:
 
 - title: String? - Title label text.
 - message: String? - Message label text.
 - image: UIImage? - An image of imageView..
 - actions: String - The actions that the user can take in response to the alert or action sheet..
 - messageLabelTextAlignment: String - Message label text alignment..
 - messageFont: String - Message label font style..
 - titleFont: String - Title label font style.
 - messageTextColor: String - Message label text color..
 - titleTextColor: String - Title label text color.

 ## Example to create AlertView
 # Code
 ```
 AlertView(
     image: Image(uiImage: Asset.Documents.Solid.accountDetailSolid.image),
     title: "Заголовок в одну или две строки",
     message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
     buttonTitle: "Действие",
     buttonAction: {},
     additionalButtonTitle: "Альтернативное действие",
     additionalButtonAction: {})
 ```
 */
@available(iOS 14.0, *)
public struct AlertView: View {

    // MARK: - Constants

    private enum Constants {
        static let imageViewIllustration: CGFloat = LayoutGrid.halfModule * 35
        static let imageViewIcon: CGFloat = 54.0

        static let titleFameWidth: CGFloat = LayoutGrid.halfModule * 47

        static let imageSpacing: CGFloat = LayoutGrid.halfModule * 5
        static let titleSpacing: CGFloat = 10
        static let subTitleSpacing: CGFloat = LayoutGrid.halfModule * 10

        static let lineLimit: Int = 2
    }

    // MARK: - Internal Properties
    
    /// Flag loading button.
    @Binding var isLoading: Bool

    // MARK: - Private properties
    
    /// Type size image from alert view.
    private var imageType: AlertViewImageType
    
    /// Title label text color style.
    private var titleTextLabelColor: AlertColorStyle
    
    /// Message label text color style.
    private var messageTextLabelColor: AlertColorStyle

    /// Title label font style.
    private var titleLabelFontStyle: AlertTitleFontStyle
    
    /// Message label font style.
    private var messageLabelFontStyle: AlertMessageFontStyle
    
    /// The image of the alert.
    private var image: Image?
    
    /// The text that the title label displays.
    private var title: String?
    
    /// Descriptive text that provides more details about the reason for the alert.
    private var message: String?
    
    /// The text that the button displays.
    private var buttonTitle: String?
    
    /// Action button.
    private var buttonAction: (() -> ())?
    
    /// The text that the additionalButtonTitle displays.
    private var additionalButtonTitle: String?
    
    /// Action additionalButtonAction.
    private var additionalButtonAction: (() -> ())?

    @Binding private var scheme: AlertViewScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<AlertViewScheme>()

    // MARK: - Computed Properties

    /// Frame type for imege view
    private var imageViewFrame: CGFloat {
        get {
            switch imageType {
            case .icon:
                return Constants.imageViewIcon
            case .illustration:
                return Constants.imageViewIllustration
            }
        }
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init (
        image: Image?,
        title: String?,
        message: String?,
        isLoading: Binding<Bool> = .constant(false),
        imageType: AlertViewImageType = .illustration,
        titleTextLabelColor: AlertColorStyle = .primary,
        messageTextLabelColor: AlertColorStyle = .additional,
        messageLabelFontStyle: AlertMessageFontStyle = .subhead3,
        titleLabelFontStyle: AlertTitleFontStyle = .title1,
        buttonTitle: String? = nil,
        buttonAction: (() -> ())? = nil,
        additionalButtonTitle: String? = nil,
        additionalButtonAction: (() -> ())? = nil,
        scheme: Binding<AlertViewScheme?> = .constant(nil)
    ) {
        self._isLoading = isLoading
        self.imageType = imageType
        self.titleTextLabelColor = titleTextLabelColor
        self.messageTextLabelColor = messageTextLabelColor
        self.messageLabelFontStyle = messageLabelFontStyle
        self.titleLabelFontStyle = titleLabelFontStyle
        self.image = image
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.additionalButtonTitle = additionalButtonTitle
        self.additionalButtonAction = additionalButtonAction
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack(alignment: .center, spacing: 0) {
            Spacer()
                .frame(height: LayoutGrid.quadrupleModule)
            
            if let image = image {
                image
                    .resizable()
                    .frame(width: imageViewFrame, height: imageViewFrame)
                Spacer()
                    .frame(height: Constants.imageSpacing)
            }
            
            if let title = title {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(scheme.titleFont.parameter(style: titleLabelFontStyle)?.swiftUIFont)
                    .lineLimit(Constants.lineLimit)
                    .foregroundColor(scheme.titleColor.parameter(style: titleTextLabelColor)?.swiftUIColor)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                    .frame(height: Constants.titleSpacing)
            }

            if let message = message {
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(scheme.messageFont.parameter(style: messageLabelFontStyle)?.swiftUIFont)
                    .foregroundColor(scheme.messageColor.parameter(style: messageTextLabelColor)?.swiftUIColor)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                    .frame(height: Constants.subTitleSpacing)
            }
                if let buttonTitle = buttonTitle,
                   let buttonAction = buttonAction {
                    Button(buttonTitle, action: buttonAction)
                        .buttonStyle(PrimaryButtonStyle(isLoading: $isLoading))
                }
                if let additionalButtonTitle = additionalButtonTitle,
                   let additionalButtonAction = additionalButtonAction {
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule)
                    HStack {
                        Spacer()
                        Button(additionalButtonTitle, action: additionalButtonAction)
                            .buttonStyle(GhostButtonStyle())
                        Spacer()
                    }
                }
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
        }
        .padding(.horizontal, LayoutGrid.doubleModule)
        .background(scheme.backgroundColor.swiftUIColor)
        .cornerRadius(LayoutGrid.doubleModule)
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: Binding<AlertViewScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }
    
}

@available(iOS 14.0, *)
struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlertView(
                image: Image(uiImage: Asset.Documents.Solid.accountDetailSolid.image),
                title: "Заголовок в одну или две строки",
                message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                buttonTitle: "Действие",
                buttonAction: {},
                additionalButtonTitle: "Альтернативное действие",
                additionalButtonAction: {})
                .padding()
        }
    }
}
