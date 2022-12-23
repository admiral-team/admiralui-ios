//
//  TralingComponentsViewController.swift
//  ExampleiOS
//
//  Created on 18.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit
// swiftlint:disable all

final class TralingElementsViewController: ScrollViewController {
    
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
        navigationItem.title = "Traling elements"
        
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
        cells.append(configureArrowCell())
        cells.append(configureRadioButtonCell())
        cells.append(configureCheckBoxCell())
        cells.append(configureSwitchListViewCell())
        cells.append(configureCurcleIconListViewCell())
        cells.append(configureCardListViewCell())
        cells.append(configureIconListViewCell())
        cells.append(configureDatePercentListViewCell())
        cells.append(configureImageWithSubtitleListViewCell())
        cells.append(configureSubtitleWithImageListViewCell())
        
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
            let isSelectedCell = cell == view
            cell.isHighlighted = isSelectedCell
        }
    }

    private func configureArrowCell() -> ListCell<ListCellEmpty, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Title"
        return ListCell(centerView: titleListView, tralingView: ArrowListView())
    }
    
    private func configureRadioButtonCell() -> ListCell<ListCellEmpty, TitleListView, RadioButtonListView> {
        let radioButtonView = RadioButtonListView()
        radioButtonView.isSelected = true
        radioButtonView.didSelect = {}
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, RadioButtonListView> = ListCell(centerView: titleListView, tralingView: radioButtonView)
        cell.accessibilityIdentifier = "RadioButtonCell"
        return cell
    }
    
    private func configureCheckBoxCell() -> ListCell<ListCellEmpty, TitleListView, CheckBoxListView> {
        let checkBoxCell = CheckBoxListView()
        checkBoxCell.checkBoxAccesibilityId = "CheckBoxListViewCheckBox"
        checkBoxCell.accessibilityIdentifier = "CheckBoxListView"
        checkBoxCell.isSelected = true
        checkBoxCell.didSelect = {}
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, CheckBoxListView> = ListCell(centerView: titleListView, tralingView: checkBoxCell)
        cell.accessibilityIdentifier = "CheckBoxCell"
        return cell
    }
    
    private func configureSwitchListViewCell() -> ListCell<ListCellEmpty, TitleListView, SwitchListView> {
        let switchListView = SwitchListView()
        switchListView.didSelect = { isOn in
            print(isOn)
        }
        switchListView.customSwitchAccesibilityId = "SwitchListViewSwitcher"
        switchListView.accessibilityIdentifier = "SwitchListView"
        switchListView.isControlSelected = true
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, SwitchListView> = ListCell(centerView: titleListView, tralingView: switchListView)
        cell.accessibilityIdentifier = "SwitchListViewCell"
        return cell
    }
    
    private func configureCardListViewCell() -> ListCell<ListCellEmpty, TitleListView, CardListView> {
        let сardListView = CardListView()
        сardListView.cardImage = Asset.Card.visa.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, CardListView> = ListCell(centerView: titleListView, tralingView: сardListView)
        cell.accessibilityIdentifier = "CardListViewCell"
        return cell
    }
    
    private func configureIconListViewCell() -> ListCell<ListCellEmpty, TitleListView, IconListView> {
        let iconListView = IconListView()
        iconListView.image = Asset.Main.calendar.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, IconListView> = ListCell(centerView: titleListView, tralingView: iconListView)
        cell.accessibilityIdentifier = "IconListViewCell"
        return cell
    }
    
    private func configureDatePercentListViewCell() -> ListCell<ListCellEmpty, TitleListView, DatePercentListView> {
        let datePercentListView = DatePercentListView()
        datePercentListView.date = "Date"
        datePercentListView.percent = "Percent"
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, DatePercentListView> = ListCell(centerView: titleListView, tralingView: datePercentListView)
        cell.accessibilityIdentifier = "DatePercentListViewCell"
        return cell
    }
    
    private func configureImageWithSubtitleListViewCell() -> ListCell<ListCellEmpty, TitleListView, ImageWithSubtitleListView> {
        let imageWithSubtitleListView = ImageWithSubtitleListView()
        imageWithSubtitleListView.subtitle = "Subtitle"
        imageWithSubtitleListView.image = Asset.Card.mir.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, ImageWithSubtitleListView> = ListCell(centerView: titleListView, tralingView: imageWithSubtitleListView)
        cell.accessibilityIdentifier = "ImageWithSubtitleListViewCell"
        return cell
    }
    
    private func configureSubtitleWithImageListViewCell() -> ListCell<ListCellEmpty, TitleListView, SubtitleWithImageListView> {
        let imageWithSubtitleListView = SubtitleWithImageListView()
        imageWithSubtitleListView.subtitle = "Subtitle"
        imageWithSubtitleListView.image = Asset.Card.mir.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, SubtitleWithImageListView> = ListCell(centerView: titleListView, tralingView: imageWithSubtitleListView)
        cell.accessibilityIdentifier = "SubtitleWithImageListViewCell"
        return cell
    }
    
    private func configureCurcleIconListViewCell() -> ListCell<ListCellEmpty, TitleListView, CurcleIconListView> {
        let curcleIconListView = CurcleIconListView()
        curcleIconListView.image = Asset.Card.rnb.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cell: ListCell<ListCellEmpty, TitleListView, CurcleIconListView> = ListCell(centerView: titleListView, tralingView: curcleIconListView)
        cell.accessibilityIdentifier = "CurcleIconListViewCell"
        return cell
    }
    
}
