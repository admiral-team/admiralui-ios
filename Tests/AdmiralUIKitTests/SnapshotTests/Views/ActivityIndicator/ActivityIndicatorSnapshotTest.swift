import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ActivityIndicatorSnapshotTest: XCTestCase {
    
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
        // TODO: - Fix test
        let view = createView(size: .small)
        self.checkView(view: view, named: "Small", testName: "ActivityIndicator")
    
    }
    
    func testActivityIndicatorMediumState() {
        // TODO: - Fix test
        let view = createView(size: .medium)
        self.checkView(view: view, named: "Medium", testName: "ActivityIndicator")
    }
    
    func testActivityIndicatorLargeState() {
        // TODO: - Fix test
        let view = createView(size: .large)
        self.checkView(view: view, named: "Large", testName: "ActivityIndicator")
    }
    
    // MARK: - Private Methods
    
    private func createView(size: ActivityIndicator.Size) -> UIView {
        let view = ActivityIndicator()
        view.frame.size = CGSize(width: 120.0, height: 120.0)
        view.size = size
        view.style = .default
        view.apply(theme: theme)
        
        let superview = UIView(frame: UIScreen.main.bounds)
        superview.addSubview(view)
        superview.backgroundColor = .white
        view.frame.origin.x = superview.frame.midX
        view.frame.origin.y = superview.frame.midY
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        view.startAnimating()
        
        return superview
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



