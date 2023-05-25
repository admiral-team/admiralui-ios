import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralImages
@testable import AdmiralUIKit

class StatusHistorySnapshotTest: XCTestCase {
    
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
      
    func testStatusHistoryDateDefaultState() {
        let view = createStatusHistoryDateView()
        checkView(view: view, named: "Default", testName: "StatusHistoryDateView")
    }
    
    func testStatusHistoryBaseImagesViewDefaultState() {
        let view = createStatusHistoryBaseImagesView()
        checkView(view: view, named: "Default", testName: "StatusHistoryBaseImagesView")
    }
    
    func testStatusHistoryStatusViewDoneState() {
        let view = createStatusHistoryStatusView(status: .done)
        checkView(view: view, named: "Done", testName: "StatusHistoryStatusView")
    }
    
    func testStatusHistoryStatusViewErrorState() {
        let view = createStatusHistoryStatusView(status: .error)
        checkView(view: view, named: "Error", testName: "StatusHistoryStatusView")
    }
    
    func testStatusHistoryStatusViewHoldState() {
        let view = createStatusHistoryStatusView(status: .hold)
        checkView(view: view, named: "Hold", testName: "StatusHistoryStatusView")
    }
    
    func testStatusHistoryStatusViewReviewState() {
        let view = createStatusHistoryStatusView(status: .review)
        checkView(view: view, named: "Review", testName: "StatusHistoryStatusView")
    }
    
    func testStatusHistoryTitleViewDefaultState() {
        let view = createStatusHistoryTitleView()
        checkView(view: view, named: "Default", testName: "StatusHistoryTitleView")
    }
    
    // MARK: - Private Methods
    
    private func createStatusHistoryDateView() -> UIView {
        let view = StatusHistoryDateView()
        view.dateText = "01.01.2020"
        view.frame.size = CGSize(width: 220.0, height: 220.0)
        view.apply(theme: theme)
        
        return view
    }
    
    private func createStatusHistoryBaseImagesView() -> UIView {
        let view = StatusHistoryBaseImagesView()
        view.images = [AdmiralImages.Asset.Finance.Solid.cardSolid.image,
                       AdmiralImages.Asset.Finance.Solid.creditCardSolid.image,
                       AdmiralImages.Asset.Finance.Solid.gbpSolid.image]
        view.frame.size = CGSize(width: 100.0, height: 100.0)
        view.apply(theme: theme)
        
        return view
    }
    
    private func createStatusHistoryStatusView(status: StatusHistory) -> UIView {
        let view = StatusHistoryStatusView()
        view.statusText = "Status"
        view.statusImage = AdmiralImages.Asset.Category.Solid.bankSolid.image
        view.status = status
        view.frame.size = CGSize(width: 300.0, height: 300.0)
        view.apply(theme: theme)
        
        return view
    }
    
    private func createStatusHistorySumView(type: StatusHistoryViewType, statusHistorySumType: StatusHistorySumType) -> UIView {
        let view = StatusHistorySumView()
        view.sum = "333"
        view.crossOutSum = "444"
        view.type = type
        view.statusHistorySumType = statusHistorySumType
        view.frame.size = CGSize(width: 300.0, height: 300.0)
        view.apply(theme: theme)
        
        return view
    }
    
    private func createStatusHistoryTitleView() -> UIView {
        let view = StatusHistoryTitleView()
        view.title = "Title"
        view.subtitle = "Subtitle"
        view.frame.size = CGSize(width: 300.0, height: 60.0)
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
