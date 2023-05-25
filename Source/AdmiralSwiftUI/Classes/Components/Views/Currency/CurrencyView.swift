//
//  CurrencyView.swift
//  AdmiralSwiftUI
//
//  Created on 02.08.2021.
//

import SwiftUI
import AdmiralTheme
/**
 CurrencyCellType - Public enum for type CurrencyCell

 CurrencyCellType can be one of the following values:
 - arrowUp - Cell with ArrowUp Image.
 - arrowDown - Cell with ArrowDown Image.
 - empty - Cell without image. There is an indent from the right edge.
 - none - Cell without image. The position of the cell is at the right edge.
 */
/// The style of currency cell.
public enum CurrencyCellType {
    /// Cell with ArrowUp Image.
    case arrowUp
    /// Cell with ArrowDown Image.
    case arrowDown
    /// Cell without image. There is an indent from the right edge.
    case empty
    /// Cell without image. The position of the cell is at the right edge.
    case none
}

/**
 CurrencyView - The view for display currency.

 You can create a CurrencyView with the zero frame rectangle by specifying the following parameters in init:

 - currencyText: String - The text that the currency label displays.
 - buyText: String - The text that the buy label displays.
 - sellText: String - The text that the sell label displays.
 - image: Image? - The image that the image view displays.
 - firstCellType: CurrencyCellType - A value that configures style of buy price.
 - secondCellType: CurrencyCellType - A value that configures style of sell price.

 - CurrencyCellType - The style of currency cell. Can be: arrowUp (cell with ArrowDown Image), arrowDown (cell without image. There is an indent from the right edge), empty (cell without image. The position of the cell is at the right edge), none

 ## Example to create CurrencyView
 # Code
 ```
 CurrencyView(
     currencyText: "USD",
     buyText: "68,85",
     sellText: "69,45",
     image: nil,
     firstCellType: .arrowUp,
     secondCellType: .arrowDown
 )
```
 */
/// The view for display currency.
@available(iOS 14.0.0, *)
public struct CurrencyView: View {

    /// The text that the currency label displays.
    @Binding public var currencyText: String

    /// The text that the buy label displays.
    @Binding public var buyText: String

    /// The text that the sell label displays.
    @Binding public var sellText: String

    /// The image that the image view displays.
    @Binding public var image: Image?

    /// A value that configures style of buy price.
    @Binding public var firstCellType: CurrencyCellType

    /// A value that configures style of sell price.
    @Binding public var secondCellType: CurrencyCellType

    // MARK: Internal Properties

    @ObservedObject var schemeProvider: SchemeProvider<CurrencyViewScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        currencyText: String,
        buyText: String,
        sellText: String,
        image: Image? = nil,
        firstCellType: CurrencyCellType = .none,
        secondCellType: CurrencyCellType = .none,
        schemeProvider: SchemeProvider<CurrencyViewScheme> = AppThemeSchemeProvider<CurrencyViewScheme>()
    ) {
        self._currencyText = Binding(get: { return currencyText }, set: { _ in})
        self._buyText = Binding(get: { return buyText }, set: { _ in})
        self._sellText = Binding(get: { return sellText }, set: { _ in})
        self._image = Binding(get: { return image }, set: { _ in })
        self._firstCellType = Binding(get: { return firstCellType }, set: { _ in })
        self._secondCellType = Binding(get: { return secondCellType }, set: { _ in })
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        HStack(alignment: .center, spacing: .zero) {
            currencyView(scheme: scheme)
            Spacer()
            quotationView(text: buyText, cellType: firstCellType, scheme: scheme)
            Spacer()
                .frame(width: LayoutGrid.halfModule * 10)
            quotationView(text: sellText, cellType: secondCellType, scheme: scheme)
        }
    }

    // MARK: - Private Methods

    private func currencyView(scheme: CurrencyViewScheme) -> some View {
        if let image = image {
            return HStack(alignment: .center, spacing: LayoutGrid.halfModule * 3, content: {
                image
                    .foregroundColor(scheme.imageTintColor.swiftUIColor)
                    .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 5)
                Text(currencyText)
                    .foregroundColor(scheme.textColor.swiftUIColor)
                    .font(scheme.textFont.swiftUIFont)
            })
            .eraseToAnyView()
        } else {
            return Text(currencyText)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
                .eraseToAnyView()
        }
    }

    private func quotationView(text: String, cellType: CurrencyCellType, scheme: CurrencyViewScheme) -> some View {
        HStack(alignment: .center, spacing: .zero, content: {
            switch cellType {
            case .none:
                textView(text: text, scheme: scheme)
            case .empty:
                textView(text: text, scheme: scheme)
                Spacer()
                    .frame(width: LayoutGrid.tripleModule)
            case .arrowUp:
                textView(text: text, scheme: scheme)
                imageView(image: SymbolAssets.System.Outline.arrowUp.swiftUIImage, scheme: scheme)
            case .arrowDown:
                textView(text: text, scheme: scheme)
                imageView(image: SymbolAssets.System.Outline.arrowDown.swiftUIImage, scheme: scheme)
            }
        })
        .frame(width: 90.0)
    }

    @ViewBuilder private func textView(text: String, scheme: CurrencyViewScheme) -> some View {
        Spacer()
        Text(text)
            .font(scheme.textFont.swiftUIFont)
            .foregroundColor(scheme.textColor.swiftUIColor)
            .multilineTextAlignment(.trailing)
    }

    private func imageView(image: Image, scheme: CurrencyViewScheme) -> some View {
        image
            .foregroundColor(scheme.imageTintColor.swiftUIColor)
            .frame(width: LayoutGrid.tripleModule, height: LayoutGrid.tripleModule)
    }

}

@available(iOS 14.0, *)
struct CurrencyView_Previews: PreviewProvider {

    @State static var text: String = ""

    static var previews: some View {
        CurrencyView(
            currencyText: "USD",
            buyText: "68,85",
            sellText: "69,45",
            image: nil,
            firstCellType: .arrowUp,
            secondCellType: .arrowDown
        )
    }

}
