import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ActionBarViewSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    // MARK: - View

    func testActionCellViewDefault() {
        let view = createActionBar(
            style: .default,
            actions: [
                createAction(imageStyle: .error),
                createAction(imageStyle: .accent),
                createAction(imageStyle: .attention),
                createAction(imageStyle: .success),
                createAction(imageStyle: .primary)
            ],
            size: CGSize(width: 240, height: 80)
        )
        checkView(view: view, named: "Default", testName: "ActionBarView")
    }

    func testActionCellViewSecondary() {
        let view = createActionBar(
            style: .secondary,
            actions: [
                createAction(imageStyle: .error, style: .secondary, text: "Text"),
                createAction(imageStyle: .accent, style: .secondary, text: "Text"),
                createAction(imageStyle: .primary, style: .secondary, text: "Text")
            ],
            size: CGSize(width: 270, height: (LayoutGrid.halfModule * 18))
        )
        checkView(view: view, named: "Secondary", testName: "ActionBarView")
    }

    // MARK: - Private Methods

    private func createActionBar(
        style: ActionBarViewStyle,
        actions: [ActionItemBarAction],
        size: CGSize
    ) -> ActionBarView {
        let actionBarView = ActionBarView(style: style)
        actions.forEach { actionBarView.appendAction($0) }
        actionBarView.frame.size = size
        actionBarView.apply(theme: theme)
        return actionBarView
    }

    private func createAction(
        _ image: UIImage = Asset.Category.Outline.acceptOutline.image,
        imageStyle: ActionBarItemImageStyle,
        style: ActionBarItemStyle = .default,
        text: String? = nil
    ) -> ActionItemBarAction {
        return ActionItemBarAction(
            image: image,
            imageStyle: imageStyle,
            style: style,
            text: text,
            handler: {}
        )
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

