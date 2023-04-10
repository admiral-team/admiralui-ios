import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ShimmeringViewSnapshotTest: XCTestCase {
    
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
      
    func testViewDefaultState() {
        let view = createView()
        checkView(view: view, named: "Default", testName: "ShimmeringView")
    }
    
    // MARK: - Private Methods
    
    private func createView() -> UIView {
        let view = ShimmeringView()
        view.start()
        
        view.frame.size = CGSize(width: 120.0, height: 2.0)
        view.apply(theme: theme)
        
        return view
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





