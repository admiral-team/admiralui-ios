import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class LeadingComponentsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    func testTitleCell() {
        let view = configureTitleCell("Title")
        checkView(view: view, named: "Default", testName: "TitleListView")
    }
    
    func testTitleSubtitleCell() {
        let view = configureTitleSubtitleCell("Title", subtitle: "Subtitle")
        checkView(view: view, named: "Default", testName: "TitleSubtitleListView")
    }
    
    func testSubtitleTitleCell() {
        let view = configureSubtitleTitleCell("Title", subtitle: "Subtitle")
        checkView(view: view, named: "Default", testName: "SubtitleTitleListView")
    }
    
    func testTitleMoreDetaileTextMessageListView() {
        let view = configureTitleMoreDetaileTextMessageListView()
        checkView(view: view, named: "Default", testName: "TitleMoreDetailTextMessageListView")
    }
    
    func testTitleSubtitleButtonListView() {
        let view = configureTitleSubtitleButtonListView()
        checkView(view: view, named: "Default", testName: "TitleSubtitleButtonListView")
    }
    
    func testTextMessageListViewCell() {
        let view = configureTextMessageListViewCell("Text")
        checkView(view: view, named: "Default", testName: "TextMessageListView")
    }
    
    // MARK: - View
      
    private func configureTitleCell(_ title: String?) -> ListCell<ListCellEmpty, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = title
        let listCell = ListCell<ListCellEmpty, TitleListView, ArrowListView>(centerView: titleListView, tralingView: ArrowListView())
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureTitleSubtitleCell(_ title: String?, subtitle: String?) -> ListCell<ListCellEmpty, TitleSubtitleListView, ArrowListView> {
        let titleSubtitleListView = TitleSubtitleListView()
        titleSubtitleListView.title = title
        titleSubtitleListView.subtitle = subtitle
        let listCell = ListCell<ListCellEmpty, TitleSubtitleListView, ArrowListView>(centerView: titleSubtitleListView, tralingView: ArrowListView())
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureSubtitleTitleCell(_ title: String?, subtitle: String?) -> ListCell<ListCellEmpty, SubtitleTitleListView, ArrowListView> {
        let subtitleTitleListView = SubtitleTitleListView()
        subtitleTitleListView.title = title
        subtitleTitleListView.subtitle = subtitle
        let listCell = ListCell<ListCellEmpty, SubtitleTitleListView, ArrowListView>(centerView: subtitleTitleListView, tralingView: ArrowListView())
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureTitleMoreDetaileTextMessageListView() -> ListCell<ListCellEmpty, TitleMoreDetailTextMessageListView, ArrowListView> {
        let leadingView = TitleMoreDetailTextMessageListView()
        leadingView.title = "Title"
        leadingView.more = "More"
        leadingView.subtitle = "Subtitle"
        leadingView.detaileMore = "More"
        leadingView.detaile = "Detail"
        leadingView.tagText = "Tag"
        leadingView.messageText = "Message"
        let listCell = ListCell<ListCellEmpty, TitleMoreDetailTextMessageListView, ArrowListView>(centerView: leadingView, tralingView: ArrowListView())
        listCell.frame.size = CGSize(width: 320.0, height: 120.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureTitleSubtitleButtonListView() -> ListCell<ListCellEmpty, TitleSubtitleButtonListView, ArrowListView> {
        let leadingView = TitleSubtitleButtonListView()
        leadingView.title = "Title"
        leadingView.subtitle = "Subtitle 2"
        leadingView.tagText = "Tag"
        leadingView.tagSubtitle = "Subtitle"
        leadingView.buttonTitle = "Button"
        leadingView.didSelect = {
            print("Select")
        }
        let listCell = ListCell<ListCellEmpty, TitleSubtitleButtonListView, ArrowListView>(centerView: leadingView, tralingView: ArrowListView())
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureTextMessageListViewCell(_ text: String?) -> ListCell<ListCellEmpty, TextMessageListView, ArrowListView> {
        let textMessageListView = TextMessageListView()
        textMessageListView.text = text
        let listCell = ListCell<ListCellEmpty, TextMessageListView, ArrowListView>(centerView: textMessageListView, tralingView: ArrowListView())
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    // MARK: - Private Methods
    
    
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
