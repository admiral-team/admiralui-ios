import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class TralingComponentsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    func testArrowCelll() {
        let view = configureArrowCell()
        checkView(view: view, named: "Default", testName: "ArrowListView")
    }
    
    func testRadioButtonCell() {
        let view = configureRadioButtonCell()
        checkView(view: view, named: "Default", testName: "RadioButtonCell")
    }
    
    func testCheckBoxCell() {
        let view = configureCheckBoxCell()
        checkView(view: view, named: "Default", testName: "CheckBoxListView")
    }
    
    func testSwitchListViewCell() {
        let view = configureSwitchListViewCell()
        checkView(view: view, named: "Default", testName: "SwitchListView")
    }
    
    func testCardListViewCell() {
        let view = configureCardListViewCell()
        checkView(view: view, named: "Default", testName: "CardListView")
    }
    
    func testIconListViewCell() {
        let view = configureIconListViewCell()
        checkView(view: view, named: "Default", testName: "IconListView")
    }
    
    func testDatePercentListViewCell() {
        let view = configureDatePercentListViewCell()
        checkView(view: view, named: "Default", testName: "DatePercentListView")
    }
    
    func testImageWithSubtitleListViewCell() {
        let view = configureImageWithSubtitleListViewCell()
        checkView(view: view, named: "Default", testName: "ImageWithSubtitleListView")
    }
    
    func testCurcleIconListViewCell() {
        let view = configureCurcleIconListViewCell()
        checkView(view: view, named: "Default", testName: "CurcleIconListView")
    }
    
    // MARK: - View
      
    private func configureArrowCell() -> ListCell<ListCellEmpty, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, ArrowListView>(centerView: titleListView, tralingView: ArrowListView())
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureRadioButtonCell() -> ListCell<ListCellEmpty, TitleListView, RadioButtonListView> {
        let radioButtonView = RadioButtonListView()
        radioButtonView.isHighlightedEnabled = false
        let titleListView = TitleListView()
        titleListView.isHighlightedEnabled = false
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, RadioButtonListView>(centerView: titleListView, tralingView: radioButtonView)
        listCell.frame.size = CGSize(width: 320.0, height: 84.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureCheckBoxCell() -> ListCell<ListCellEmpty, TitleListView, CheckBoxListView> {
        let checkBoxCell = CheckBoxListView()
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, CheckBoxListView>(centerView: titleListView, tralingView: checkBoxCell)
        listCell.frame.size = CGSize(width: 320.0, height: 84.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureSwitchListViewCell() -> ListCell<ListCellEmpty, TitleListView, SwitchListView> {
        let switchListView = SwitchListView()
        switchListView.didSelect = { (isOn) in
            print(isOn)
        }
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, SwitchListView>(centerView: titleListView, tralingView: switchListView)
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureCardListViewCell() -> ListCell<ListCellEmpty, TitleListView, CardListView> {
        let сardListView = CardListView()
        сardListView.cardImage = Asset.Category.Outline.bankOutline.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, CardListView>(centerView: titleListView, tralingView: сardListView)
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureIconListViewCell() -> ListCell<ListCellEmpty, TitleListView, IconListView> {
        let iconListView = IconListView()
        iconListView.image = AdmiralUIResources.Asset.System.Outline.arrowCrossOutline.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, IconListView>(centerView: titleListView, tralingView: iconListView)
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureDatePercentListViewCell() -> ListCell<ListCellEmpty, TitleListView, DatePercentListView> {
        let datePercentListView = DatePercentListView()
        datePercentListView.date = "Date"
        datePercentListView.percent = "Percent"
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, DatePercentListView>(centerView: titleListView, tralingView: datePercentListView)
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureImageWithSubtitleListViewCell() -> ListCell<ListCellEmpty, TitleListView, ImageWithSubtitleListView> {
        let imageWithSubtitleListView = ImageWithSubtitleListView()
        imageWithSubtitleListView.subtitle = "Subtitle"
        imageWithSubtitleListView.image = Asset.System.Outline.arrowCrossOutline.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, ImageWithSubtitleListView>(centerView: titleListView, tralingView: imageWithSubtitleListView)
        listCell.frame.size = CGSize(width: 320.0, height: 80.0)
        listCell.apply(theme: theme)
        return listCell
    }
    
    private func configureCurcleIconListViewCell() -> ListCell<ListCellEmpty, TitleListView, CurcleIconListView> {
        let curcleIconListView = CurcleIconListView()
        curcleIconListView.image = Asset.System.Outline.arrowCrossOutline.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let listCell = ListCell<ListCellEmpty, TitleListView, CurcleIconListView>(centerView: titleListView, tralingView: curcleIconListView)
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
