//
//  SecondaryTitleListView.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 SecondaryTitleListView - A view object with big title.
 
 You can create a SecondaryTitleListView with the zero frame rectangle by specifying the following parameters in init:
 - title: String? - The text that the subtitle label displays.
 - state: ControlState - The state of the view. Default is normal.
 - lineLimit: Int? - Line limit of title text. By default is nil
 
 ## Example to create SecondaryTitleListView
 # Code
 ```
 SecondaryTitleListView(title: "Title")
```
 */
/// A view object with big title.
@available(iOS 14.0.0, *)
public struct SecondaryTitleListView: View, LeadingListViewComponent {
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    /// The text that the label displays.
    @Binding public var title: String?
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    /// The state of the view. Default is normal.
    @State var state: ControlState = .normal

    // MARK: - Private Properties
    
    @State private var scheme: SecondaryTitleListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SecondaryTitleListViewScheme>()

    private let lineLimit: Int?


    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        lineLimit: Int? = nil,
        scheme: SecondaryTitleListViewScheme? = nil
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self.lineLimit = lineLimit
        self.scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        Text(title ?? "")
            .multilineTextAlignment(.leading)
            .lineLimit(lineLimit)
            .font(scheme.titleFont.swiftUIFont)
            .foregroundColor(isEnabled ? scheme.textColor.parameter(for: .normal)?.swiftUIColor : scheme.textColor.parameter(for: .disabled)?.swiftUIColor)
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: SecondaryTitleListViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
}

@available(iOS 14.0, *)
struct SecondaryTitleListView_Previews: PreviewProvider {

    static var previews: some View {
        SecondaryTitleListView(title: "Title")
    }

}
