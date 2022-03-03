import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class NumberBadgeViewSnapshotTest: XCTestCase {
    
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
        let view = createView(style: .default)
        checkView(view: view, named: "Default", testName: "NumberBadge")
    }
    
    func testViewAttentionState() {
        let view = createView(style: .attention)
        checkView(view: view, named: "Attention", testName: "NumberBadge")
    }
    
    func testViewAdditionalState() {
        let view = createView(style: .additional)
        checkView(view: view, named: "Additional", testName: "NumberBadge")
    }
    
    func testViewErrorState() {
        let view = createView(style: .error)
        checkView(view: view, named: "Error", testName: "NumberBadge")
    }
    
    func testViewSuccessState() {
        let view = createView(style: .success)
        checkView(view: view, named: "Success", testName: "NumberBadge")
    }
    
    // MARK: - Private Methods
    
    private func createView(style: BadgeStyle) -> UIView {
        let view = NumberBadge()
        view.value = 1
        view.style = style
        view.frame.size = CGSize(width: 24.0, height: 24.0)
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




