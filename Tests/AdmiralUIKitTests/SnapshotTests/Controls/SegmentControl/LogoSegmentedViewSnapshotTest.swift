import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class LogoSegmentedViewSnapshotTest: XCTestCase {
    
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
        checkControl(control: control, named: "Default", testName: "LogoSegmentedControl")
    }
    
    // MARK: - Private Methods
    
    private func createControl() -> UIControl {
        let segmentControl = LogoTab(
        images: [AdmiralUIResources.Asset.Category.Solid.bankSolid.image,
                 AdmiralUIResources.Asset.Category.Solid.carSolid.image,
                 AdmiralUIResources.Asset.Category.Solid.chartSolid.image])
        segmentControl.frame = CGRect(
            origin: .zero,
            size: CGSize(width: 320.0, height: 64.0))
        segmentControl.selectedSegmentIndex = 1
        segmentControl.apply(theme: theme)
        return segmentControl
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


