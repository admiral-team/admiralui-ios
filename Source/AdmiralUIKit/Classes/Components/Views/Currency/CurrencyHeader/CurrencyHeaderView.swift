//
//  CurrencyHeaderView.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import UIKit
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
let header = CurrencyHeaderView(
    currencyText: "USDT",
    buyText: "SELL",
    sellText: BUY,
    isTextSpacingEnabled: true
)
```
 */
/// The view for display header currency.
public final class CurrencyHeaderView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let height: CGFloat = LayoutGrid.module * 5
        static let trailingSell: CGFloat = LayoutGrid.halfModule * 11
        static let trailingBuy: CGFloat = 46
    }

    // MARK: - Public properties

    /// The text of currency label.
    public var currencyText: String? {
        didSet {
            currencyTextLabel.text = currencyText
        }
    }

    /// The text of buy label.
    public var buyText: String? {
        didSet {
            buyTextLabel.text = currencyText
        }
    }

    /// The text of sell label.
    public var sellText: String? {
        didSet {
            sellTextLabel.text = currencyText
        }
    }

    /// The spacing between sell label and buy label
    public var isTextSpacingEnabled: Bool = false {
        didSet {
            trailingConstraint.constant = isTextSpacingEnabled ? LayoutGrid.tripleModule : .zero
        }
    }

    /// Color scheme.
    public var scheme = CurrencyHeaderViewScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Internal Properties

    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Private properties

    private let currencyTextLabel = UILabel()
    private let buyTextLabel = UILabel()
    private let sellTextLabel = UILabel()
    private let overView = UIView()
    private var trailingConstraint = NSLayoutConstraint()

    // MARK: - Initializer

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func apply(theme: AppTheme) {
        scheme = CurrencyHeaderViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        [overView].addToSuperview(self)
        [currencyTextLabel, sellTextLabel, buyTextLabel].addToSuperview(overView)
    }

    private func setupConstraints() {
        trailingConstraint =
        overView.trailingAnchor.constraint(
            equalTo: sellTextLabel.trailingAnchor,
            constant: isTextSpacingEnabled ? LayoutGrid.tripleModule : .zero
        )

        NSLayoutConstraint.activate([
            overView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overView.trailingAnchor.constraint(equalTo: leadingAnchor),
            overView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overView.topAnchor.constraint(equalTo: topAnchor),
            overView.heightAnchor.constraint(equalToConstant: Constants.height),
            overView.widthAnchor.constraint(equalTo: widthAnchor),

            currencyTextLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            currencyTextLabel.leadingAnchor.constraint(equalTo: overView.leadingAnchor),

            sellTextLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            trailingConstraint,

            buyTextLabel.topAnchor.constraint(equalTo: overView.topAnchor),

            sellTextLabel.leadingAnchor.constraint(equalTo: buyTextLabel.trailingAnchor, constant: Constants.trailingBuy)
        ])
    }

    private func updateScheme() {
        updateColors()
        updateFonts()
    }

    private func updateFonts() {
        currencyTextLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        buyTextLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        sellTextLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

    private func updateColors() {
        overView.backgroundColor = scheme.backgroundColor.uiColor
        currencyTextLabel.textColor = scheme.textColor.uiColor
        buyTextLabel.textColor = scheme.textColor.uiColor
        sellTextLabel.textColor = scheme.textColor.uiColor
    }

}
