//
//  TextBaseCellViewController.swift
//  ExampleiOS
//
//  Created on 23.11.2020.
//

import AdmiralUIKit
import AdmiralUIResources
import AdmiralTheme
import UIKit

final class TextBaseCellViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [TextBaseCellView]()
    private enum Constants {
        static let cellText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        
        title = "Text Cells"
        configureUI()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        views.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureSwithes()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureSwithes() {
        let titleListView = TitleListView()
        titleListView.title = Constants.cellText
        let listView1 = ListCell<ListCellEmpty, TitleListView, ListCellEmpty>(
            centerView: titleListView,
            tralingView: nil)
        let textBaseView = TextBaseCellView(
            cell: listView1,
            title: "Text Cell")
        views.append(textBaseView)
        
        let titleListView2 = TitleListView()
        titleListView2.title = Constants.cellText
        let iconListView = IconListView()
        iconListView.image = AdmiralUIResources.Asset.Service.Outline.infoOutline.image
        let listView2 = ListCell<ListCellEmpty, TitleListView, IconListView>(
            centerView: titleListView2,
            tralingView: iconListView)
        let textBaseView2 = TextBaseCellView(
            cell: listView2,
            title: "Text Cell vs Icon")
        views.append(textBaseView2)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
