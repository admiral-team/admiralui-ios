//
//  ErrorView.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ErrorView - the component is used to attract the user's attention as a message.
 
 You can create a ZeroScreenView with the zero frame rectangle by specifying the following parameters in init: 
 
 - text: String - Information text
 - button Title: String - Title for the button
 - isLoadingButton: Binding<Bool> - For button with an activity indicator
 - button Action: @escaping () -> () - Closure for processing button tap
 
 ## Example to create ErrorView
 # Code
 ```
 public var body: some View {
    ErrorView(
            text: "Text",
            buttonTitle: "Title",
            isLoadingButton: .constant(false)),
            buttonAction: {})
 }
```
 */
@available(iOS 14.0, *)
public struct ErrorView: View {
    
    private enum Constants {
        static let imageSize = CGSize(width: 54.0, height: 54.0)
    }

    // MARK: - Public Properties
    
    /// The text that the text label displays.
    public var text: String?
    
    /// The text that the button displays.
    public var buttonTitle: String?

    /// Action button.
    public var buttonAction: () -> ()
    
    /// Flag loading button.
    @Binding public var isLoadingButton: Bool
    
    // MARK: Internal Properties

    @State var scheme: ErrorViewScheme?
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ErrorViewScheme>()
    
    // MARK: - Initializer
    
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        text: String? = nil,
        buttonTitle: String? = nil,
        isLoadingButton: Binding<Bool> = .constant(false),
        buttonAction: @escaping () -> () = {}) {
        self.text = text
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self._isLoadingButton = isLoadingButton
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack(alignment: .center, spacing: 0.0, content: {
            Spacer()
            if let text = text {
                Text(text)
                    .font(scheme.titleFont.swiftUIFont)
                    .foregroundColor(scheme.titleColor.swiftUIColor)
                    .frame(height: LayoutGrid.doubleModule * 4)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
            }
            Spacer()
                .frame(height: LayoutGrid.halfModule * 10)
            if let buttonTitle = buttonTitle {
                Button(buttonTitle, action: buttonAction)
                    .buttonStyle(GhostButtonStyle(isLoading: $isLoadingButton))
            }
            Spacer()
        })
    }
    
    // MARK: - Internal Methods

    func scheme(_ scheme: ErrorViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }

}

@available(iOS 14.0, *)
struct ErrorView_Previews: PreviewProvider {

    static var previews: some View {
        ErrorView(
            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            buttonTitle: "Альтернативное действие",
            buttonAction: {})
            .previewLayout(.fixed(width: 300.0, height: 400.0))
            .padding(.horizontal, LayoutGrid.doubleModule)
    }
    
}

