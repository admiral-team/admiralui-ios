import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class AlertViewSnapshotTest: XCTestCase {
    
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
      
    func testActivityIndicatorSmallState() {
        let view = createAlertView()
        checkView(view: view, named: "Default", testName: "AlertView")
    }
    
    // MARK: - Private Methods
    
    private func createAlertView() -> UIView {
        let vc = AlertViewController()
        vc.title = "Title"
        vc.message = "Message"
<<<<<<< HEAD:Tests/AdmiralUIKitTests/SnapshotTests/Views/AlertView/AlertView.swift
        vc.image = Asset.Communication.Solid.phoneSolid.image
=======
        vc.image = Asset.Communication.Solid.signalSolid.image
>>>>>>> develop:Tests/SnapshotTests/Views/AlertView/AlertView.swift
        vc.addAction(AlertAction(title: "ActionOne", style: .primary, handler: nil))
        vc.addAction(AlertAction(title: "ActionTwo", style: .alternative, handler: nil))
        vc.view.frame.size = CGSize(width: 320.0, height: 420.0)
        return vc.view
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
