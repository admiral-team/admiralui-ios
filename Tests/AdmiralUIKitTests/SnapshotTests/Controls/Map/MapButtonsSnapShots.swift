import XCTest
import SnapshotTesting
import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class MapButtonSnapShots: XCTestCase {

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        Appearance.prepare()
        let theme = Appearance.shared.theme
        return theme
    }()

    // MARK: - Primary

    func testaMapButtonPlus() {
        let button = createButtonContainer(type: .plus)
        checkButton(buttonContainer: button, named: "Default.Plus", testName: "MapButton")
    }

    func testMapButtonLocation() {
        let button = createButtonContainer(type: .location)
        checkButton(buttonContainer: button, named: "Default.Location", testName: "MapButton")
    }

    func testMapButtonMinus() {
        let button = createButtonContainer(type: .minus)
        checkButton(buttonContainer: button, named: "Default.Minus", testName: "MapButton")
    }

    func testMapButtonDisabled() {
        let button = createButtonContainer(type: .custom(image: Asset.Location.Solid.gpsSolid.image), isEnabled: false)
        checkButton(buttonContainer: button, named: "Disabled.Custom", testName: "MapButton")
    }

    func testMapButtonHighlighted() {
        let button = createButtonContainer(type: .custom(image: Asset.Location.Solid.gpsSolid.image), isHighlighted: true)
        checkButton(buttonContainer: button, named: "Highlighted.Custom", testName: "MapButton")
    }

    // MARK: - Private Methods

    private func createMapButton(
        type: MapButtonType,
        size: CGSize = CGSize(width: 40, height: 40),
        isEnabled: Bool = true,
        isHighlighted: Bool = false
    ) -> UIButton {
        let button = MapButton(frame: CGRect(origin: .zero, size: size))
        button.isHighlighted = isHighlighted
        button.isEnabled = isEnabled
        button.type = type
        button.apply(theme: theme)
        return button
    }

    private func createButtonContainer(
        type: MapButtonType,
        size: CGSize = CGSize(width: 40, height: 40),
        isEnabled: Bool = true,
        isHighlighted: Bool = false
    ) -> UIView {
        let button = createMapButton(type: type, size: size, isEnabled: isEnabled, isHighlighted: isHighlighted)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = theme.colors.backgroundAdditionalTwo.uiColor
        view.addSubview(button)
        button.center = view.convert(view.center, from:view.superview)
        return view
    }

    private func checkButton(buttonContainer: UIView, named: String, testName: String) {
        let result = verifySnapshot(
                matching: buttonContainer,
                as: .image,
                named: named,
                file: getFilePath(),
                testName: testName
        )
        XCTAssertNil(result)
    }
    
}
