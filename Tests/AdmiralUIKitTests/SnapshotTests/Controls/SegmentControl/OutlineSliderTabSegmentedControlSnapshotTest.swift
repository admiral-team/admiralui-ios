import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class OutlineSliderTabSegmentedControlSnapshotTest: XCTestCase {
    
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
        checkControl(control: control, named: "Default", testName: "OutlineSliderTabSegmentedControl")
    }
    
    // MARK: - Private Methods
    
    private func createControl() -> UIControl {
        let control = OutlineSliderTabSegmentedControl(titles: ["Title"])
        control.frame = CGRect(origin: .zero, size: CGSize(width: 320.0, height: 80.0))
        control.insertTitle("Title1", forSegmentAt: 0)
        control.insertTitle("Title2", forSegmentAt: 1)
        control.apply(theme: theme)
        return control
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

