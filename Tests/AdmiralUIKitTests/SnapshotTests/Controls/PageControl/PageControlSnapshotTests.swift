import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class PageControlSnapshotTests: XCTestCase {
    
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
      
    func testPageControlDefaultState() {
        let pageControl = createPageControl()
        checkControl(control: pageControl, named: "Default", testName: "PageControl")
    }
    
    // MARK: - Private Methods
    
    private func createPageControl() -> UIControl {
        let pageControl = PageControl()
        pageControl.currentPage = 1
        pageControl.numberOfPages = 5
        pageControl.isEnabled = true
        pageControl.apply(theme: theme)
        pageControl.frame.size = CGSize(width: 120.0, height: LayoutGrid.quadrupleModule)
        return pageControl
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

