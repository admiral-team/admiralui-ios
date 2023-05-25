import XCTest
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralUIKit

final class CurrencyViewTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Default Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testDefaultCurrency() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            theme: theme
        )
        checkView(view: view, named: "Default.Light", testName: "CurrencyView")
    }

    func testDefaultCurrencyFlags() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            theme: theme
        )
        checkView(view: view, named: "Flags.Light", testName: "CurrencyView")
    }

    func testDefaultCurrencyIcons() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: theme
        )
        checkView(view: view, named: "Icons.Light", testName: "CurrencyView")
    }

    func testDefaultCurrencyIconsFlags() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: theme
        )
        checkView(view: view, named: "Icons.Flags.Light", testName: "CurrencyView")
    }

    // MARK: - Dark theme

    func testDefaultCurrencyDark() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            theme: AppTheme.dark
        )
        checkView(view: view, named: "Default.Dark", testName: "CurrencyView")
    }

    func testDefaultCurrencyFlagsDark() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            theme: AppTheme.dark
        )
        checkView(view: view, named: "Flags.Dark", testName: "CurrencyView")
    }

    func testDefaultCurrencyIconsDark() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: AppTheme.dark
        )
        checkView(view: view, named: "Icons.Dark", testName: "CurrencyView")
    }

    func testDefaultCurrencyIconsFlagsDark() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: AppTheme.sMELight
        )
        checkView(view: view, named: "Icons.Flags.Dark", testName: "CurrencyView")
    }

    // MARK: - SME Light theme

    func testDefaultCurrencySme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            theme: AppTheme.sMELight
        )
        checkView(view: view, named: "Default.SME.Light", testName: "CurrencyView")
    }

    func testDefaultCurrencyFlagsSme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            theme: AppTheme.sMELight
        )
        checkView(view: view, named: "Flags.SME.Light", testName: "CurrencyView")
    }

    func testDefaultCurrencyIconsSme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: AppTheme.sMELight
        )
        checkView(view: view, named: "Icons.SME.Light", testName: "CurrencyView")
    }

    func testDefaultCurrencyIconsFlagsSme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: AppTheme.sMELight
        )
        checkView(view: view, named: "Icons.Flags.SME.Light", testName: "CurrencyView")
    }

    // MARK: - SME Dark theme

    func testDefaultCurrencyDarkSme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            theme: AppTheme.sMEDark
        )
        checkView(view: view, named: "Default.SME.Dark", testName: "CurrencyView")
    }

    func testDefaultCurrencyFlagsDarkSme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            theme: AppTheme.sMEDark
        )
        checkView(view: view, named: "Flags.SME.Dark", testName: "CurrencyView")
    }

    func testDefaultCurrencyIconsDarkSme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: AppTheme.sMEDark
        )
        checkView(view: view, named: "Icons.SME.Dark", testName: "CurrencyView")
    }

    func testDefaultCurrencyIconsFlagsDarkSme() {
        let view = createCurrencyView(
            buyText: "купить",
            sellText: "продать",
            image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
            sellCellType: .arrowDown,
            buyCellType: .arrowUp,
            theme: AppTheme.sMEDark
        )
        checkView(view: view, named: "Icons.Flags.SME.Dark", testName: "CurrencyView")
    }

    // MARK: - Private Methods

    private func createCurrencyView(
        buyText: String,
        sellText: String,
        image: UIImage? = nil,
        currencyText: String = "USDT",
        sellCellType: CurrencyCellType? = nil,
        buyCellType: CurrencyCellType? = nil,
        theme: AppTheme
    ) -> CurrencyView {
        let currency = CurrencyView()
        currency.buyCellType = buyCellType
        currency.sellCellType = sellCellType
        currency.buyText = buyText
        currency.sellText = sellText
        currency.currencyText = currencyText
        currency.image = image
        currency.frame.size = CGSize(width: 300, height: LayoutGrid.module * 5)
        currency.apply(theme: theme)
        return currency
    }

    private func checkView(view: UIView, named: String, testName: String) {
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}

