import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI


private struct ButtonWrapper<T: View>: View {

    // MARK: - Properties
    let view: T
    let disabled: Bool

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 48)
            .disabled(disabled)
    }
    
}

final class ButtonSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - TwoTitlePrimary Button Default Theme

    func testTwoTitlePrimaryButton() {
        Appearance.shared.theme = .default
        let twoTitlePrimaryButton = TwoTitlePrimaryButton(
            leftText: "leftText",
            rightText: "rightText",
            action: {}
        )
        checkButton(view: twoTitlePrimaryButton, named: "twoTitle", testName: "PrimaryButton")
    }
    
    // MARK: - TwoTitlePrimary Button Dark Theme

    func testTwoTitlePrimaryButtonDarkTheme() {
        Appearance.shared.theme = .dark
        let twoTitlePrimaryButton = TwoTitlePrimaryButton(
            leftText: "leftText",
            rightText: "rightText",
            action: {}
        )
        checkButton(view: twoTitlePrimaryButton, named: "twoTitleDarkTheme", testName: "PrimaryButton")
    }

    // MARK: - TwoTitleGhost Button Default Theme

    func testTwoTitleGhostButton() {
        Appearance.shared.theme = .default
        let twoTitleGhostButton = TwoTitleGhostButton(
            leftText: "leftText",
            rightText: "rightText",
            leftAction: {},
            rightAction: {}
        )
        checkButton(view: twoTitleGhostButton, named: "twoTitle", testName: "GhostButton")
    }
    
    // MARK: - TwoTitleGhost Button Dark Theme

    func testTwoTitleGhostButtonDarkTheme() {
        Appearance.shared.theme = .dark
        let twoTitleGhostButton = TwoTitleGhostButton(
            leftText: "leftText",
            rightText: "rightText",
            leftAction: {},
            rightAction: {}
        )
        checkButton(view: twoTitleGhostButton, named: "twoTitleDarkTheme", testName: "GhostButton")
    }


    // MARK: - Ghost Button Default Theme

    func testGhostButton() {
        Appearance.shared.theme = .default
        let ghostButton = Button("Text", action: {})
                .buttonStyle(GhostButtonStyle(isLoading: .constant(false)))
        checkButton(view: ghostButton, named: "Ghost", testName: "Button")
    }
    
    // MARK: - Ghost Button Dark Theme

    func testGhostButtonDarkTheme() {
        Appearance.shared.theme = .dark
        let ghostButton = Button("Text", action: {})
                .buttonStyle(GhostButtonStyle(isLoading: .constant(false)))
        checkButton(view: ghostButton, named: "GhostDarkTheme", testName: "Button")
    }

    // MARK: - Primary Button Default Theme

    func testPrimaryButtonBig() {
        Appearance.shared.theme = .default
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .big))
        checkButton(view: primaryButton, named: "primaryButton", testName: "Big")
    }

    func testPrimaryButtonMedium() {
        Appearance.shared.theme = .default
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .medium))
        checkButton(view: primaryButton, named: "primaryButton", testName: "Medium")
    }

    func testPrimaryButtonSmall() {
        Appearance.shared.theme = .default
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
        checkButton(view: primaryButton, named: "primaryButton", testName: "Small")
    }

    func testPrimaryButtonBigDisabled() {
        Appearance.shared.theme = .default
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .big))
        checkButton(view: primaryButton, named: "primaryButtonDisabled", testName: "Big", disabled: true)
    }

    func testPrimaryButtonMediumDisabled() {
        Appearance.shared.theme = .default
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .medium))
        checkButton(view: primaryButton, named: "primaryButtonDisabled", testName: "Medium", disabled: true)
    }

    func testPrimaryButtonSmallDisabled() {
        Appearance.shared.theme = .default
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
        checkButton(view: primaryButton, named: "primaryButtonDisabled", testName: "Small", disabled: true)
    }

    // MARK: - Primary Button Dark Theme

    func testPrimaryButtonBigDarkTheme() {
        Appearance.shared.theme = .dark
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .big))
        checkButton(view: primaryButton, named: "primaryButtonDarkTheme", testName: "Big")
    }

    func testPrimaryButtonMediumDarkTheme() {
        Appearance.shared.theme = .dark
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .medium))
        checkButton(view: primaryButton, named: "primaryButtonDarkTheme", testName: "Medium")
    }

    func testPrimaryButtonSmallDarkTheme() {
        Appearance.shared.theme = .dark
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
        checkButton(view: primaryButton, named: "primaryButtonDarkTheme", testName: "Small")
    }

    func testPrimaryButtonBigDisabledDarkTheme() {
        Appearance.shared.theme = .dark
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .big))
        checkButton(view: primaryButton, named: "primaryButtonDisabledDarkTheme", testName: "Big", disabled: true)
    }

    func testPrimaryButtonMediumDisabledDarkTheme() {
        Appearance.shared.theme = .dark
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .medium))
        checkButton(view: primaryButton, named: "primaryButtonDisabledDarkTheme", testName: "Medium", disabled: true)
    }

    func testPrimaryButtonSmallDisabledDarkTheme() {
        Appearance.shared.theme = .dark
        let primaryButton =  Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
        checkButton(view: primaryButton, named: "primaryButtonDisabledDarkTheme", testName: "Small", disabled: true)
    }

    // MARK: - Secondary Button Style Default Theme

    func testSecondaryButtonStyle() {
        Appearance.shared.theme = .default
        let secondaryButton = Button("Text", action: {})
            .buttonStyle(SecondaryButtonStyle(isLoading: .constant(false)))
        checkButton(view: secondaryButton, named: "secondary", testName: "Button")
    }
    
    // MARK: - Secondary Button Style Dark Theme

    func testSecondaryButtonStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let secondaryButton = Button("Text", action: {})
            .buttonStyle(SecondaryButtonStyle(isLoading: .constant(false)))
        checkButton(view: secondaryButton, named: "secondaryDarkTheme", testName: "Button")
    }

    // MARK: - Platform Button Style Default Theme
    
    func testPlatformButtonStyle() {
        Appearance.shared.theme = .default
        let platfotmButton = Button("Text", action: {})
            .buttonStyle(PlatformButtonStyle())
        checkButton(view: platfotmButton, named: "platform", testName: "Button")
    }
    
    // MARK: - Platform Button Style Dark Theme

    func testPlatformButtonStyleDarkTheme() {
        Appearance.shared.theme = .default
        let platfotmButton = Button("Text", action: {})
            .buttonStyle(PlatformButtonStyle())
        checkButton(view: platfotmButton, named: "platformDarkTheme", testName: "Button")
    }
}

private extension ButtonSnapshotTests {

    func checkButton<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let buttonWrapper = ButtonWrapper(view: view, disabled: disabled)
        let view = UIHostingController(rootView: buttonWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}

