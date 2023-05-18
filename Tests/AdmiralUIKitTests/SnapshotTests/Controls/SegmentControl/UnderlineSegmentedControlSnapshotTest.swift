import XCTest
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralUIKit

class UnderlineSegmentedControlSnapshotTest: XCTestCase {
    
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
        checkControl(control: control, named: "Default", testName: "UnderlineSegmentedControl")
    }
    
    // MARK: - Private Methods
    
    private func createControl() -> UIControl {
        let control = UnderlineSegmentedControl(items: ["Title"])
        control.apply(theme: theme)
        control.frame = CGRect(origin: .zero, size: CGSize(width: 520.0, height: 40.0))
        control.insertTitle("Title1", forSegmentAt: 0)
        control.insertTitle("Title2", forSegmentAt: 1)
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


