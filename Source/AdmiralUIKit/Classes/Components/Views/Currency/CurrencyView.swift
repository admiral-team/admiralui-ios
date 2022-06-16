//
//  CurrencyView.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/// The style of currency cell.
public enum CurrencyCellType {
    /// Cell with ArrowUp Image.
    case arrowUp
    /// Cell with ArrowDown Image.
    case arrowDown
    /// Cell without image. There is an indent from the right edge.
    case empty
}
/**
 CurrencyView - The view for display currency.

 You can create a CurrencyView with the zero frame rectangle by specifying the following parameters in init:

 - currencyText: String - The text that the currency label displays.
 - buyText: String - The text that the buy label displays.
 - sellText: String - The text that the sell label displays.
 - image: UIImage? - The image that the image view displays.
 - buyCellType: CurrencyCellType - A value that configures style of buy price.
 - sellCellType: CurrencyCellType - A value that configures style of sell price.

 - CurrencyCellType - The style of currency cell. Can be: arrowUp (cell with ArrowDown Image), arrowDown (cell without image. There is an indent from the right edge), empty (cell without image. The position of the cell is at the right edge), none

 ## Example to create CurrencyView
 # Code
 let currency = CurrencyView()
 currency.image = Asset.System.Outline.arrowDownOutline.image
 currency.sellCellType = .arrowUp
 currency.sellText = "Продать"
 currency.buyText = "Покупка"
 currency.buyCellType = .arrowUp
 currency.currencyText = "Валюта"
 ```
 */
/// The view for display currency.
public final class CurrencyView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let height: CGFloat = LayoutGrid.module * 5
        static let trailingSell: CGFloat = LayoutGrid.halfModule * 11
        static let trailingBuy: CGFloat = 46
        static let buyTrailing: CGFloat = 126
        static let buyTrailingDefault: CGFloat = 102
    }

    // MARK: - Public Properties

    /// An image of Currency.
    public var image: UIImage? = nil {
        didSet {
            imageView.image = image
            updateCurrencyConstraints()
        }
    }

    /// The text of currencyTextLabel.
    public var currencyText: String? = nil {
        didSet {
            currencyTextLabel.text = currencyText
        }
    }

    /// The text of buyTextLabel.
    public var buyText: String? = nil {
        didSet {
            buyTextLabel.text = buyText
        }
    }

    /// The text of sellTextLabel.
    public var sellText: String? = nil {
        didSet {
            sellTextLabel.text = sellText
        }
    }

    /// The type of sell cell.
    public var sellCellType: CurrencyCellType? = nil {
        didSet {
            updateSellConstraints()
        }
    }

    /// The type of buy cell.
    public var buyCellType: CurrencyCellType? = nil {
        didSet {
            updateBuyConstraints()
        }
    }

    // MARK: - Internal Properties

    var scheme = CurrencyViewScheme() {
        didSet { updateScheme() }
    }

    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Private properties

    private let overView = UIView()

    private let currencyTextLabel = UILabel()
    private let imageView = UIImageView()

    private let buyTextLabel = UILabel()
    private let buyImageView = UIImageView()

    private let sellTextLabel = UILabel()
    private let sellImageView = UIImageView()

    /// Currency constraints.
    private var currencyLeading = NSLayoutConstraint()
    private var imageLeading = NSLayoutConstraint()
    private var imageTrailing = NSLayoutConstraint()

    /// Sell constraints.
    private var sellTrailing = NSLayoutConstraint()
    private var sellImageTrailing = NSLayoutConstraint()

    /// Buy constraints
    private var buyTrailing = NSLayoutConstraint()
    private var buyImageTrailing = NSLayoutConstraint()

    // MARK: - Initializer

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func apply(theme: AppTheme) {
        scheme = CurrencyViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        [overView].addToSuperview(self)
        [currencyTextLabel,
         imageView,
         sellTextLabel,
         sellImageView,
         buyTextLabel,
         buyImageView
        ].addToSuperview(overView)
    }

    private func setupConstraints() {
        currencyLeading = currencyTextLabel.leadingAnchor.constraint(equalTo: overView.leadingAnchor)
        imageLeading = imageView.leadingAnchor.constraint(equalTo: overView.leadingAnchor)
        imageTrailing = currencyTextLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LayoutGrid.halfModule * 3)

        sellTrailing = overView.trailingAnchor.constraint(equalTo: sellTextLabel.trailingAnchor)
        sellImageTrailing = sellImageView.trailingAnchor.constraint(equalTo: overView.trailingAnchor)

        buyTrailing = overView.trailingAnchor.constraint(equalTo: buyTextLabel.trailingAnchor, constant: Constants.buyTrailingDefault)
        buyImageTrailing = overView.trailingAnchor.constraint(equalTo: buyImageView.trailingAnchor, constant: Constants.buyTrailingDefault)

        NSLayoutConstraint.activate([
            overView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overView.trailingAnchor.constraint(equalTo: leadingAnchor),
            overView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overView.topAnchor.constraint(equalTo: topAnchor),
            overView.heightAnchor.constraint(equalToConstant: Constants.height),
            overView.widthAnchor.constraint(equalTo: widthAnchor),

            currencyLeading,
            imageLeading,
            imageLeading,

            sellTrailing,
            sellImageTrailing,

            buyTrailing,
            buyImageTrailing,

            currencyTextLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            sellTextLabel.topAnchor.constraint(equalTo: overView.topAnchor),
            buyTextLabel.topAnchor.constraint(equalTo: overView.topAnchor),

            imageView.topAnchor.constraint(equalTo: overView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),

            buyImageView.topAnchor.constraint(equalTo: overView.topAnchor),
            buyImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            buyImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),

            sellImageView.topAnchor.constraint(equalTo: overView.topAnchor),
            sellImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            sellImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule)
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
        sellImageView.tintColor = scheme.imageTintColor.uiColor
        buyImageView.tintColor = scheme.imageTintColor.uiColor
        imageView.tintColor = scheme.imageTintColor.uiColor
    }

}

// MARK: - Update constraints cycle
private extension CurrencyView {

    func updateCurrencyConstraints() {
        imageLeading.isActive = image != nil
        imageTrailing.isActive = image != nil
        currencyLeading.isActive = image == nil
    }

    func updateSellConstraints() {
        switch sellCellType {
        case .arrowUp:
            sellTrailing.constant = LayoutGrid.tripleModule
            sellImageView.image = Asset.Location.Outline.gpsOutline.image
            sellImageView.isHidden = false
            sellImageTrailing.constant = .zero
        case .arrowDown:
            sellTrailing.constant = LayoutGrid.tripleModule
            sellImageView.image = Asset.System.Outline.arrowDownOutline.image
            sellImageView.isHidden = false
            sellImageTrailing.constant = .zero
        case .empty:
            sellImageView.isHidden = true
            sellTrailing.constant = LayoutGrid.tripleModule
            sellImageTrailing.constant = .zero
        default:
            sellImageView.isHidden = true
            sellTrailing.constant = .zero
        }
    }

    func updateBuyConstraints() {
        switch buyCellType {
        case .arrowUp:
            buyImageView.isHidden = false
            buyImageTrailing.constant = Constants.buyTrailingDefault
            buyTrailing.constant = Constants.buyTrailing
            buyImageView.image = Asset.System.Outline.arrowUpOutline.image
        case .arrowDown:
            buyImageView.isHidden = false
            buyImageTrailing.constant = Constants.buyTrailingDefault
            buyTrailing.constant = Constants.buyTrailing
            buyImageView.image = Asset.System.Outline.arrowDownOutline.image
        case .empty:
            buyImageView.isHidden = true
            buyImageTrailing.constant = .zero
            buyTrailing.constant = Constants.buyTrailing
        default:
            buyImageView.isHidden = true
            buyImageTrailing.constant = .zero
            buyTrailing.constant = Constants.buyTrailingDefault
        }
    }

}
