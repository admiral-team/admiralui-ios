import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class PinSnapShots: XCTestCase {

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        Appearance.prepare()
        let theme = Appearance.shared.theme
        return theme
    }()

    // MARK: - Primary

    func testPinButtonDefaultState() {
        let button = createPinButton()
        checkButton(button: button, named: "Default", testName: "PinButton")
    }

    func testPinButtonDisabledState() {
        let button = createPinButton()
        button.isEnabled = false
        checkButton(button: button, named: "Disabled", testName: "PinButton")
    }

    func testPinButtonHiglitedState() {
        let button = createPinButton()
        button.isHighlighted = true
        checkButton(button: button, named: "Highlighted", testName: "PinButton")
    }

    func testPinButtonSelectedState() {
        let button = createPinButton(isSelected: true)
        checkButton(button: button, named: "Selected", testName: "PinButton")
    }

    // MARK: - Private Methods

    private func createPinButton(
        isSelected: Bool = false,
        frame: CGRect = CGRect(origin: .zero, size: CGSize(width: 36, height: 36))
    ) -> UIButton {
        let button = PinButton()
        button.image = Asset.Location.Solid.gpsSolid.image
        button.frame = frame
        button.apply(theme: theme)
        button.isSelected = isSelected
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
