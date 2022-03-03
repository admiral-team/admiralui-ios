import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class CalendarViewSnapshotTest: XCTestCase, CalendarDataSource {
    
    var startDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: "2019 12 01")!
        return date
    }()
    
    var endDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: "2020 01 01")!
        return date
    }()
    
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
        checkView(view: view, named: "Default", testName: "CalendarView")
    }
    
    // MARK: - Private Methods
    
    private func createView() -> UIView {
        let calendarView = CalendarVerticalView()
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.locale = Locale(identifier: "ru")
        calendarView.reloadData()
        calendarView.frame.size = CGSize(width: 320.0, height: 320.0)
        calendarView.apply(theme: theme)
        
        return calendarView
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

extension CalendarViewSnapshotTest: CalendarDelegate {
    
}
