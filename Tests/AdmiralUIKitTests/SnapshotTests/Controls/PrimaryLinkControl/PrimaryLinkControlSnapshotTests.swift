import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class PrimaryLinkControlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - CustomSwitch
      
    func testDefaultState() {
        let control = createControl()
        checkControl(control: control, named: "Default", testName: "PrimaryLinkControl")
    }
    
    // MARK: - Private Methods
    
    private func createControl() -> UIControl {
        let linkView = PrimaryLinkControl()
        linkView.frame = CGRect(origin: .zero, size: CGSize(width: 80.0, height: 64.0))

        linkView.leadingImage = AdmiralUIResources.Asset.System.Outline.arrowLeftOutline.image
        linkView.setTitle("Title")
        return linkView
    }
    
    private func checkControl(control: UIControl, named: String, testName: String) {
        let result = verifySnapshot(
            matching: control,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}


