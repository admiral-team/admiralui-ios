//
//  CurrencyHeaderView.swift
//  AdmiralSwiftUI
//
//  Created on 02.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 CurrencyHeaderView - The view for display header currency.

 You can create a CurrencyHeaderView with the zero frame rectangle by specifying the following parameters in init:

 - currencyText: String - text for currency
 - buyText: String - text for buy view
 - sellText: String - text for sell view
 - isTextSpacingEnabled: Bool - additional spacing for CurrencyHeaderView

 ## Example to create CurrencyHeaderView
 # Code
 ```
 CurrencyHeaderView(
     currencyText: "Валюта",
     buyText: "Купить",
     sellText: "Продать"
 )
```
 */
/// The view for display header currency.
@available(iOS 14.0.0, *)
public struct CurrencyHeaderView: View {
    
    // MARK: Internal Properties
    
    @State var currencyText: String
    @State var buyText: String
    @State var sellText: String
    @State var scheme: CurrencyHeaderViewScheme?

    // MARK: - Private properties

    @ObservedObject var schemeProvider = AppThemeSchemeProvider<CurrencyHeaderViewScheme>()
    private let isTextSpacingEnabled: Bool

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        currencyText: String,
        buyText: String,
        sellText: String,
        isTextSpacingEnabled: Bool = false
    ) {
        self._currencyText = .init(initialValue: currencyText)
        self._buyText = .init(initialValue: buyText)
        self._sellText = .init(initialValue: sellText)
        self.isTextSpacingEnabled = isTextSpacingEnabled
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        HStack(alignment: .center, spacing: 0.0, content: {
            Text(currencyText)
            Spacer()
            Text(buyText)
            Spacer()
                .frame(width: LayoutGrid.halfModule * 18)
            sellLabel(scheme)
        })
        .foregroundColor(scheme.textColor.swiftUIColor)
        .font(scheme.textFont.swiftUIFont)
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: CurrencyHeaderViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }

    // MARK: - Private methods

    @ViewBuilder private func sellLabel(_ scheme: CurrencyHeaderViewScheme) -> some View {
        Text(sellText)
        if isTextSpacingEnabled {
            Spacer()
                .frame(width: LayoutGrid.tripleModule)
        }
    }

}

@available(iOS 14.0, *)
struct CurrencyHeaderView_Previews: PreviewProvider {

    @State static var text: String = ""

    static var previews: some View {
        CurrencyHeaderView(
            currencyText: "Валюта",
            buyText: "Купить",
            sellText: "Продать"
        )
    }
}
