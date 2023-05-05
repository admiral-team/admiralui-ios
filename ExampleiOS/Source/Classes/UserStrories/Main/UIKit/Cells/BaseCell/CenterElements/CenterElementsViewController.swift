//
//  CenterElementsViewController.swift
//  ExampleiOS
//
//  Created on 17.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class CenterElementsViewController: ScrollViewController {
    
    var cells: [ListViewCell] = []
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        cells.forEach({ $0.apply(theme: theme) })
    }

    // MARK: - Private Methods
    
    private func configureUI() {
        navigationItem.title = "Center elements"
        
        configureCells()
        
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(changeSegment(_:)), for: .valueChanged)
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    @objc private func changeSegment(_ segment: StandardSegmentedControl) {
        let isEnabled = segment.selectedSegmentIndex == 0
        cells.forEach({
            $0.isEnabled = isEnabled
        })
    }
    
    private func configureCells() {
        cells.append(configureTitleCell("Title"))
        cells.append(configureSubtitleTitleCell("Title", subtitle: "Subtitle"))
        cells.append(configureTitleSubtitleCell("Title", subtitle: "Subtitle"))
        cells.append(configureTitleMoreDetaileTextMessageListView())
        cells.append(configureTitleSubtitleButtonListView())
        
        for index in 0..<cells.count {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapCell(_:)))
            cells[index].isUserInteractionEnabled = true
            cells[index].addGestureRecognizer(gesture)
            cells[index].tag = index
        }
    }
    
    @objc private func tapCell(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view as? ListViewCell else { return }
        
        for cell in cells {
            if cell == view {
                cell.isHighlighted = true
            } else {
                cell.isHighlighted = false
            }
        }
    }
    
    private func configureTitleCell(_ title: String?) -> ListCell<ListCellEmpty, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = title
        let cell: ListCell<ListCellEmpty, TitleListView, ArrowListView> = ListCell(centerView: titleListView, tralingView: ArrowListView())
        cell.centerOffset = LayoutGrid.doubleModule
        cell.trailingOffset = LayoutGrid.doubleModule
        cell.accessibilityIdentifier = "TitleCell"
        return cell
    }
    
    private func configureTitleSubtitleCell(_ title: String?, subtitle: String?) -> ListCell<ListCellEmpty, TitleSubtitleListView, ArrowListView> {
        let titleSubtitleListView = TitleSubtitleListView()
        titleSubtitleListView.title = title
        titleSubtitleListView.subtitle = subtitle
        let cell: ListCell<ListCellEmpty, TitleSubtitleListView, ArrowListView> = ListCell(centerView: titleSubtitleListView, tralingView: ArrowListView())
        cell.centerOffset = LayoutGrid.doubleModule
        cell.trailingOffset = LayoutGrid.doubleModule
        cell.accessibilityIdentifier = "TitleSubtitleCell"
        return cell
    }
    
    private func configureSubtitleTitleCell(_ title: String?, subtitle: String?) -> ListCell<ListCellEmpty, SubtitleTitleListView, ArrowListView> {
        let subtitleTitleListView = SubtitleTitleListView()
        subtitleTitleListView.title = title
        subtitleTitleListView.subtitle = subtitle
        let cell: ListCell<ListCellEmpty, SubtitleTitleListView, ArrowListView> = ListCell(centerView: subtitleTitleListView, tralingView: ArrowListView())
        cell.centerOffset = LayoutGrid.doubleModule
        cell.trailingOffset = LayoutGrid.doubleModule
        cell.accessibilityIdentifier = "SubtitleTitleCell"
        return cell
    }
    
    private func configureTitleMoreDetaileTextMessageListView() -> ListCell<ListCellEmpty, TitleMoreDetailTextMessageListView, ArrowListView> {
        let leadingView = TitleMoreDetailTextMessageListView()
        leadingView.title = "Title"
        leadingView.more = "More"
        leadingView.subtitle = "Subtitle"
        leadingView.detaileMore = "More"
        leadingView.detaile = "Summ"
        leadingView.tagText = "Percent"
        leadingView.messageText = "Text Message"
        let cell: ListCell<ListCellEmpty, TitleMoreDetailTextMessageListView, ArrowListView> = ListCell(centerView: leadingView, tralingView: ArrowListView())
        cell.centerOffset = LayoutGrid.doubleModule
        cell.trailingOffset = LayoutGrid.doubleModule
        cell.accessibilityIdentifier = "TitleMoreDetaileTextMessageListView"
        return cell
    }
    
    private func configureTitleSubtitleButtonListView() -> ListCell<ListCellEmpty, TitleSubtitleButtonListView, ArrowListView> {
        let leadingView = TitleSubtitleButtonListView()
        leadingView.title = "Title"
        leadingView.subtitle = "Subtitle 2"
        leadingView.tagText = "Percent"
        leadingView.tagSubtitle = "Subtitle"
        leadingView.buttonTitle = "Button"
        leadingView.buttonAccesibilityId = "TitleSubtitleButtonListViewButton"
        leadingView.accessibilityIdentifier = "TitleSubtitleButtonListView"
        leadingView.didSelect = {
            print("Select")
        }
        let cell: ListCell<ListCellEmpty, TitleSubtitleButtonListView, ArrowListView> = ListCell(centerView: leadingView, tralingView: ArrowListView())
        cell.centerOffset = LayoutGrid.doubleModule
        cell.trailingOffset = LayoutGrid.doubleModule
        cell.accessibilityIdentifier = "TitleSubtitleButtonsListCell"
        return cell
    }
    
}
