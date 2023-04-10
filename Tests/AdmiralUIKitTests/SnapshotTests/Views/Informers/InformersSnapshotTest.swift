import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class InformersSnapshotTest: XCTestCase {
    
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
      
    func testViewBigDefaultState() {
        let view = createBigView(style: .default)
        checkView(view: view, named: "Default", testName: "BigInformer")
    }
    
    func testViewBigAttentionState() {
        let view = createBigView(style: .attention)
        checkView(view: view, named: "Attention", testName: "BigInformer")
    }
    
    func testViewBigErrorState() {
        let view = createBigView(style: .error)
        checkView(view: view, named: "Error", testName: "BigInformer")
    }
    
    func testViewBigSuccessState() {
        let view = createBigView(style: .success)
        checkView(view: view, named: "Success", testName: "BigInformer")
    }
    
    func testViewMessageDefaultState() {
        let view = createMessageView()
        checkView(view: view, named: "Default", testName: "MessageInformer")
    }
    
    func testSmallInformerDefaultState() {
        let view = createSmallView(style: .default)
        checkView(view: view, named: "Default", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionState() {
        let view = createSmallView(style: .attention)
        checkView(view: view, named: "Attention", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorState() {
        let view = createSmallView(style: .error)
        checkView(view: view, named: "Error", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessState() {
        let view = createSmallView(style: .success)
        checkView(view: view, named: "Success", testName: "SmallInformer")
    }
    
    // MARK: - Private Methods
    
    private func createBigView(style: InformerStyle) -> UIView {
        let view = BigInformer()
        view.titleText = "Title"
        view.descriptionText = "Description"
        view.linkText = "Link"
        view.style = style
        view.frame.size = CGSize(width: 320.0, height: 320.0)
        view.apply(theme: theme)
        
        return view
    }
    
    private func createMessageView() -> UIView {
        let view = MessageInformer()
        view.titleText = "Title"
        view.descriptionText = "Description"
        view.subtitleText = "Subtitle"
        view.frame.size = CGSize(width: 320.0, height: 320.0)
        view.apply(theme: theme)
        
        return view
    }
    
    private func createSmallView(style: InformerStyle) -> UIView {
        let view = SmallInformer()
        view.titleText = "Title"
        view.style = style
        view.frame.size = CGSize(width: 320.0, height: 320.0)
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





