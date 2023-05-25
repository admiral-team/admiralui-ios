import XCTest
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralUIKit

class ToolbarSnapshotTest: XCTestCase {
    
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
      
    func testToolbarOneState() {
        let view = createView(count: 1)
        checkView(view: view, named: "One", testName: "Toolbar")
    }
    
    func testToolbarTwoState() {
        let view = createView(count: 2)
        checkView(view: view, named: "Two", testName: "Toolbar")
    }
    
    func testToolbarThreeState() {
        let view = createView(count: 3)
        checkView(view: view, named: "Three", testName: "Toolbar")
    }
    
    func testToolbarFourState() {
        let view = createView(count: 4)
        checkView(view: view, named: "Four", testName: "Toolbar")
    }
    
    // MARK: - Private Methods
    
    private func createView(count: Int) -> UIView {
        let toolbar = Toolbar()
        let item1 = ToolbarItem(title: "Оплатить", image: AdmiralUIResources.Asset.Category.Solid.bankSolid.image)
        let item2 = ToolbarItem(title: "Пополнить", image: AdmiralUIResources.Asset.Category.Solid.carSolid.image)
        let item3 = ToolbarItem(title: "Подробнее", image: AdmiralUIResources.Asset.Category.Solid.chatSolid.image)
        let item4 = ToolbarItem(title: "Настройки", image: AdmiralUIResources.Asset.Category.Solid.globeSolid.image)
        let items = [item1, item2, item3, item4]
        var finalItems = [ToolbarItem]()
        for index in 0..<count {
            finalItems.append(items[index])
        }
        toolbar.setItems(items: finalItems)
        toolbar.style = .vertical
        toolbar.selectionStyle = .selected
        toolbar.selectedItem = 1
        toolbar.setItemIsEnabled(at: 2, isEnabled: false)
        toolbar.setToolbarItemWidth(width: LayoutGrid.doubleModule * 4)
        toolbar.frame.size = CGSize(width: 100.0 * Double(count), height: 80.0)
        return toolbar
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
