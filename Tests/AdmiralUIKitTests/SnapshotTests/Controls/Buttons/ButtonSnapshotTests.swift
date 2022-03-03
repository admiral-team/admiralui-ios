import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ButtonSnapshotTests: XCTestCase {
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        Appearance.prepare()
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - Primary
      
    func testPrimaryButtonDefaultState() {
        let button = createPrimaryButton()
        checkButton(button: button, named: "Default", testName: "PrimaryButton")
    }
    
    func testPrimaryButtonDisabledState() {
        let button = createPrimaryButton()
        button.isEnabled = false
        checkButton(button: button, named: "Disabled", testName: "PrimaryButton")
    }
    
    func testPrimaryButtonHiglitedState() {
        let button = createPrimaryButton()
        button.isHighlighted = true
        checkButton(button: button, named: "Highlighted", testName: "PrimaryButton")
    }
    
    // MARK: - Secondary
    
    func testSecondaryButtonDefaultState() {
        let button = createSecondaryButton()
        checkButton(button: button, named: "Default", testName: "SecondaryButton")
    }
    
    func testSecondaryButtonDisabledState() {
        let button = createSecondaryButton()
        button.isEnabled = false
        checkButton(button: button, named: "Disabled", testName: "SecondaryButton")
    }
    
    func testSecondaryButtonHiglitedState() {
        let button = createSecondaryButton()
        button.isHighlighted = true
        checkButton(button: button, named: "Highlighted", testName: "SecondaryButton")
    }
    
    // MARK: - Ghost
    
    func testGhostButtonDefaultState() {
        let button = createGhostButton()
        checkButton(button: button, named: "Default", testName: "GhostButton")
    }
    
    func testGhostButtonDisabledState() {
        let button = createGhostButton()
        button.isEnabled = false
        checkButton(button: button, named: "Disabled", testName: "GhostButton")
    }
    
    func testGhostButtonHiglitedState() {
        let button = createGhostButton()
        button.isHighlighted = true
        checkButton(button: button, named: "Highlighted", testName: "GhostButton")
    }
    
    // Two Title
    
    func testTwoTitleButtonDefaultState() {
        let button = createTwoTitleButton()
        checkButton(button: button, named: "Default", testName: "TwoTitle")
    }
    
    func testTwoTitleButtonDisabledState() {
        let button = createTwoTitleButton()
        button.isEnabled = false
        checkButton(button: button, named: "Disabled", testName: "TwoTitle")
    }
    
    func testTwoTitleButtonHiglitedState() {
        let button = createTwoTitleButton()
        button.isHighlighted = true
        checkButton(button: button, named: "Highlighted", testName: "TwoTitle")
    }
    
    // MARK: - Private Methods
    
    private func createPrimaryButton() -> UIButton {
        let button = PrimaryButton(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 300, height: 48.0)))
        button.apply(theme: theme)
        button.setTitle("Primary", for: .normal)
        return button
    }
    
    private func createSecondaryButton() -> UIButton {
        let button = SecondaryButton(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 300, height: 48.0)))
        button.apply(theme: theme)
        button.setTitle("Secondary", for: .normal)
        return button
    }
    
    private func createGhostButton() -> UIButton {
        let button = GhostButton(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 300, height: 48.0)))
        button.apply(theme: theme)
        button.setTitle("Ghost", for: .normal)
        return button
    }
    
    private func createTwoTitleButton() -> UIControl {
        let button = TwoTitleButton(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 300, height: 48.0)))
        button.apply(theme: theme)
        button.leftButtonTitle = "Left Title"
        button.rightButtonTitle = "Right Title"
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
