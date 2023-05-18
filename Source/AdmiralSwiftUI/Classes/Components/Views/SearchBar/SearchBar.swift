//
//  SearchBar.swift
//  AdmiralSwiftUI
//
//  Created on 15.06.2021.
//
import AdmiralTheme
import AdmiralUIResources
import SwiftUI
/**
 SearchBar - A specialized view for receiving search-related information from the user.
 You can create a SearchBar with the zero frame rectangle by specifying the following parameters in init:
 - content: String? - The text that the search bar displays.
 - contentType: UIKeyboardType - The semantic meaning for a text input area.
 - returnKeyType: UIReturnKeyType - The visible title of the Return key.
 - autocapitalizationType: UITextAutocapitalizationType - The autocapitalization style for the text object.
 - autocorrectionType: UITextAutocorrectionType - The autocorrection style for the text object.
 - placeholder: String - The string that displays when there is no other text in the search
 - searchImage: The image that is displayed left text field.

 You can sets the content type to search bar. To do this, use the:
 # Code
 ```
 func contentType(_ contentType: UIKeyboardType)
 ```
 - Parameter contentType: The content type that the text field displays.
 - Returns: Search bar.

 You can sets responder. To do this, use the:
 # Code
 ```
 func isResponder(_ isResponder: Bool)
 ```
 - Parameter isResponder: The value indicating whether this object is the first responder.
 - Returns: Search bar.

 ## Example to create SearchBar
 # Code
 ```
 SearchBar(
        .constant("Text"),
        placeholder: "Placeholder")
```
 */
/// A specialized view for receiving search-related information from the user.
@available(iOS 14.0, *)
public struct SearchBar: View, AccessabilitySupportUIKit {

    // MARK: - Constants

    enum Constants {
        static let closeImage = ImageAssets.Service.Solid.closeSolid.image
    }
    
    public static let defaultSearchImage = SymbolAssets.System.Outline.search.swiftUIImage

    // MARK: - Private Properties

    /// The text that the text field displays.
    @Binding public var content: String?

    /// The semantic meaning for a text input area.
    private var contentType: UIKeyboardType = .default

    /// The visible title of the Return key.
    private var returnKeyType: UIReturnKeyType = .default

    /// The autocapitalization style for the text object.
    private var autocapitalizationType: UITextAutocapitalizationType = .none

    /// The autocorrection style for the text object.
    private var autocorrectionType: UITextAutocorrectionType = .no

    /// The string that displays when there is no other text in the text field.
    private var placeholder: String = ""

    /// The image that is displayed left text field.
    private var searchImage: Image?

    private var isResponder: Binding<Bool>?

    @State private var isTextFieldResponder = false

    @ObservedObject private var schemeProvider: SchemeProvider<SearchBarColorScheme>

    private var accessibilityIdentifier: String?

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content:  The text that the search bar displays.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - placeholder: The string that displays when there is no other text in the search bar.
    ///   - searchImage: The image that is displayed left text field.
    public init(
        _ content: Binding<String?>,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .search,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        isResponder: Binding<Bool>? = nil,
        placeholder: String = "",
        searchImage: SwiftUI.Image? = defaultSearchImage,
        schemeProvider: SchemeProvider<SearchBarColorScheme> = AppThemeSchemeProvider<SearchBarColorScheme>()
    ) {
        self._content = content
        self.contentType = contentType
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.isResponder = isResponder
        self.placeholder = placeholder
        self.searchImage = searchImage
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let style = schemeProvider.scheme

        return HStack(alignment: .center) {
            Spacer()
                .frame(width: LayoutGrid.halfModule * 3)
            if let searchImage = searchImage {
                searchImage
                    .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
                    .foregroundColor(style.imageTintColor.swiftUIColor)
                Spacer()
                    .frame(width: LayoutGrid.module)
            }
            ZStack(alignment: .leading) {
                if (content ?? "").isEmpty {
                    Text(placeholder)
                        .foregroundColor(style.placeholderColor.swiftUIColor)
                        .font(style.placeholderFont.swiftUIFont)
                        .frame(height: LayoutGrid.tripleModule)
                }
                UIKitTextField(
                    text: $content,
                    isResponder: isResponder,
                    returnKeyType: returnKeyType,
                    autocapitalizationType: autocapitalizationType,
                    autocorrectionType: autocorrectionType,
                    textColor: style.textColor.uiColor,
                    placeholderColor: style.placeholderColor.uiColor,
                    tintColor: style.tintColor.uiColor,
                    font: style.textFont.uiFont)
                    .frame(height: LayoutGrid.tripleModule)
            }
            if !(content ?? "").isEmpty {
                Spacer()
                    .frame(width: LayoutGrid.doubleModule)
                Button(action: {
                    clear()
                }, label: {
                    Image(uiImage: Constants.closeImage)
                        .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
                        .foregroundColor(style.imageTintColor.swiftUIColor)
                })
            }
            Spacer()
                .frame(width: LayoutGrid.halfModule * 3)
        }
        .frame(height: LayoutGrid.halfModule * 9)
        .background(style.backgroundColor.swiftUIColor)
        .cornerRadius(LayoutGrid.module)

    }

    // MARK: - Public Methods

    public func accessibility(identifierUIKit: String) -> Self {
        var view = self
        view.accessibilityIdentifier = identifierUIKit
        return view
    }

    // MARK: - Private Methods

    private func clear() {
        content = ""
    }

}

@available(iOS 14.0, *)
public extension SearchBar {

    /// Sets the content type.
    /// - Parameter contentType: The content type that the text field displays.
    /// - Returns: Search bar.
    func contentType(_ contentType: UIKeyboardType) -> Self {
        SearchBar(
            $content,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            isResponder: isResponder,
            placeholder: placeholder
        )
    }

    /// Sets responder.
    /// - Parameter isResponder: The value indicating whether this object is the first responder.
    /// - Returns: Search bar.
    func isResponder(_ isResponder: Binding<Bool>?) -> Self {
        SearchBar(
            $content,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            isResponder: isResponder,
            placeholder: placeholder
        )
    }

}

@available(iOS 14.0, *)
struct SearchBar_Previews: PreviewProvider {

    @State static var text: String? = ""

    static var previews: some View {
        SearchBar($text, placeholder: "Placeholder")
    }
}

