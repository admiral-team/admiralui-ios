import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class SeveralPinSnapShots: XCTestCase {

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        Appearance.prepare()
        let theme = Appearance.shared.theme
        return theme
    }()

    // MARK: - Primary

    func testSeveralPinButtonSmall() {
        let button = createSeveralPinButton(style: .small, text: "1", size: CGSize(width: LayoutGrid.halfModule * 6, height: LayoutGrid.halfModule * 6))
        checkButton(button: button, named: "Default.Small", testName: "SeveralPinButton")
    }

    func testSeveralPinButtonMedium() {
        let button = createSeveralPinButton(style: .medium, text: "12", size: CGSize(width: LayoutGrid.halfModule * 8, height: LayoutGrid.halfModule * 8))
        checkButton(button: button, named: "Default.Medium", testName: "SeveralPinButton")
    }

    func testSeveralPinButtonLarge() {
        let button = createSeveralPinButton(style: .large, text: "123", size: CGSize(width: 40, height: 40))
        checkButton(button: button, named: "Default.Large", testName: "SeveralPinButton")
    }

    func testSeveralPinButtonLargeDisabled() {
        let button = createSeveralPinButton(style: .large, text: "123", size: CGSize(width: 40, height: 40))
        button.isEnabled = false
        checkButton(button: button, named: "Disabled.Large", testName: "SeveralPinButton")
    }

    func testSeveralPinButtonLargeisHighlighted() {
        let button = createSeveralPinButton(style: .large, text: "123", size: CGSize(width: 40, height: 40))
        button.isHighlighted = true
        checkButton(button: button, named: "Highlighted.Large", testName: "SeveralPinButton")
    }

    // MARK: - Private Methods

    private func createSeveralPinButton(
        style: SeveralPinButtonSize,
        text: String,
        size: CGSize
    ) -> UIButton {
        let button = SeveralPinButton()
        button.frame = CGRect(origin: .zero, size: size)
        button.setTitle(text, for: .normal)
        button.style = style
        button.apply(theme: theme)
        return button
    }

    private func checkButton(button: UIControl, named: String, testName: String) {
        let result = verifySnapshot(
            matching: button,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
