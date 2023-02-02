//
//  AdmiralSwiftUIToolbarTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIToolbarTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
    }
    
    func testToolbar() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tool bar"].tap()
        //app.toolbars["ToolbarDetail"].tap()
        getGroup(by: "ToolbarDetail", app: app)
    }
    
    func getGroup(by id: String, app: XCUIApplication) {
        print("touchBars \(app.touchBars[id].exists)")
        print("groups \(app.groups[id].exists)")
        print("windows \(app.windows[id].exists)")
        print("sheets \(app.sheets[id].exists)")
        print("drawers \(app.drawers[id].exists)")
        print("alerts \(app.alerts[id].exists)")
        print("dialogs \(app.dialogs[id].exists)")
        print("buttons \(app.buttons)")
        print("radioButtons \(app.radioButtons[id].exists)")
        print("radioGroups \(app.radioGroups[id].exists)")
        print("checkBoxes \(app.checkBoxes[id].exists)")
        print("disclosureTriangles \(app.disclosureTriangles[id].exists)")
        print("popUpButtons \(app.popUpButtons[id].exists)")
        print("comboBoxes \(app.comboBoxes[id].exists)")
        print("menuButtons \(app.menuButtons[id].exists)")
        print("toolbarButtons \(app.toolbarButtons[id].exists)")
        print("popovers \(app.popovers[id].exists)")
        print("keyboards \(app.keyboards[id].exists)")
        print("keys \(app.keys[id].exists)")
        print("navigationBars \(app.navigationBars[id].exists)")
        print("tabBars \(app.tabBars[id].exists)")
        print("tabGroups \(app.tabGroups[id].exists)")
        print("toolbars \(app.toolbars[id].exists)")
        print("statusBars \(app.statusBars[id].exists)")
        print("tables \(app.tables[id].exists)")
        print("tableRows \(app.tableRows[id].exists)")
        print("tableColumns \(app.tableColumns[id].exists)")
        print("outlines \(app.outlines[id].exists)")
        print("outlineRows \(app.outlineRows[id].exists)")
        print("disclosedChildRows \(app.disclosedChildRows[id].exists)")
        print("browsers \(app.browsers[id].exists)")
        print("collectionViews \(app.collectionViews[id].exists)")
        print("sliders \(app.sliders[id].exists)")
        print("pageIndicators \(app.pageIndicators[id].exists)")
        print("progressIndicators \(app.progressIndicators[id].exists)")
        print("activityIndicators \(app.activityIndicators[id].exists)")
        print("segmentedControls \(app.segmentedControls[id].exists)")
        print("pickers \(app.pickers[id].exists)")
        print("pickerWheels \(app.pickerWheels[id].exists)")
        print("switches \(app.switches[id].exists)")
        print("toggles \(app.toggles[id].exists)")
        print("links \(app.links[id].exists)")
        print("images \(app.images[id].exists)")
        print("icons \(app.icons[id].exists)")
        print("searchFields \(app.searchFields[id].exists)")
        print("scrollViews \(app.scrollViews[id].exists)")
        print("scrollBars \(app.scrollBars[id].exists)")
        print("staticTexts \(app.staticTexts[id].exists)")
        print("textFields \(app.textFields[id].exists)")
        print("secureTextFields \(app.secureTextFields[id].exists)")
        print("datePickers \(app.datePickers[id].exists)")
        print("textViews \(app.textViews[id].exists)")
        print("menus \(app.menus[id].exists)")
        print("menuItems \(app.menuItems[id].exists)")
        print("menuBars \(app.menuBars[id].exists)")
        print("menuBarItems \(app.menuBarItems[id].exists)")
        print("maps \(app.maps[id].exists)")
        print("webViews \(app.webViews[id].exists)")
        print("steppers \(app.steppers[id].exists)")
        print("incrementArrows \(app.incrementArrows[id].exists)")
        print("decrementArrows (app.decrementArrows[id].exists)")
        print("tabs \(app.tabs[id].exists)")
        print("timelines \(app.timelines[id].exists)")
        print("ratingIndicators \(app.ratingIndicators[id].exists)")
        print("valueIndicators \(app.valueIndicators[id].exists)")
        print("splitGroups \(app.splitGroups[id].exists)")
        print("splitters \(app.splitters[id].exists)")
        print("relevanceIndicators \(app.relevanceIndicators[id].exists)")
        print("colorWells \(app.colorWells[id].exists)")
        print("helpTags \(app.helpTags[id].exists)")
        print("mattes \(app.mattes[id].exists)")
        print("dockItems \(app.dockItems[id].exists)")
        print("statusItems \(app.statusItems[id].exists)")
    }
}
