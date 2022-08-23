//
//  PaddingView.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**

 Separator - separator element with height equal 16 points, exist in three different variants.
 - long - separator whole width
 - short - separator width padding 8 points
 - empty - empty line width height

 You can create a Separator by specifying the following parameters in the initializer
 ## Initializer parameters:
 - textBlockStyle: TextBlockStyle - style of separator

 ## Example to create SeparatorView with different parameters:
 # Code
 ```
 ScrollView {
     SeparatorView(paddingStyle: .long)
     SeparatorView(paddingStyle: .empty)
     SeparatorView(paddingStyle: .short)
 }
 ```
*/
/// A padding view.
@available(iOS 14.0.0, *)
public struct SeparatorView: View {

    /// Text block style.
    public var textBlockStyle: TextBlockStyle

    // MARK: - Private Properties

    @Binding private var scheme: SeparatorViewScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SeparatorViewScheme>()

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        paddingStyle: SeparatorStyle = .short,
        scheme: Binding<SeparatorViewScheme?> = .constant(nil)
    ) {
        self.textBlockStyle = paddingStyle.textBlockStyle
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return ListCell(
            centerView: {
                if textBlockStyle != .separatorEmpty {
                    Line()
                        .foregroundColor(scheme.lineTintColor.swiftUIColor)
                }
            }
        )
        .configCell(minHeight: textBlockStyle.minHeight, edgeInsets: textBlockStyle.edgeInsets)
    }
}

@available(iOS 14.0, *)
struct SeparatorView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            SeparatorView(paddingStyle: .long)
            SeparatorView(paddingStyle: .empty)
            SeparatorView(paddingStyle: .short)
        }
    }
}
