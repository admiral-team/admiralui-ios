//
//  ImageBaseCellTralingMenuController.swift
//  ExampleiOS
//
//  Created on 20.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ImageBaseCellTralingViewController: ScrollViewController {
    
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
        
        segmentControl.setTitles(["Default", "Disabled"])
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
        cells.append(configureCardListViewCell())
        cells.append(configureIconListViewCell())
        cells.append(configureDatePercentListViewCell())
        cells.append(configureImageWithSubtitleListViewCell())
//        cells.append(configureCurcleIconListViewCell())
    
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
    
    private func configureArrowCell() -> ListCell<ImageCardListView, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: ArrowListView())
    }
    
    private func configureRadioButtonCell() -> ListCell<ImageCardListView, TitleListView, RadioButtonListView> {
        let radioButtonView = RadioButtonListView()
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: radioButtonView)
    }
    
    private func configureCheckBoxCell() -> ListCell<ImageCardListView, TitleListView, CheckBoxListView> {
        let checkBoxCell = CheckBoxListView()
        checkBoxCell.isSelected = true
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: checkBoxCell)
    }
    
    private func configureSwitchListViewCell() -> ListCell<ImageCardListView, TitleListView, SwitchListView> {
        let switchListView = SwitchListView()
        switchListView.didSelect = { (isOn) in
            print(isOn)
        }
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: switchListView)
    }
    
    private func configureCardListViewCell() -> ListCell<ImageCardListView, TitleListView, CardListView> {
        let сardListView = CardListView()
        сardListView.cardImage = Asset.Card.visa.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: сardListView)
    }
    
    private func configureIconListViewCell() -> ListCell<ImageCardListView, TitleListView, IconListView> {
        let iconListView = IconListView()
        iconListView.image = Asset.Main.calendar.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: iconListView)
    }
    
    private func configureDatePercentListViewCell() -> ListCell<ImageCardListView, TitleListView, DatePercentListView> {
        let datePercentListView = DatePercentListView()
        datePercentListView.date = "Date"
        datePercentListView.percent = "Percent"
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: datePercentListView)
    }
    
    private func configureImageWithSubtitleListViewCell() -> ListCell<ImageCardListView, TitleListView, ImageWithSubtitleListView> {
        let imageWithSubtitleListView = ImageWithSubtitleListView()
        imageWithSubtitleListView.subtitle = "Subtitle"
        imageWithSubtitleListView.image = Asset.Card.mir.image
        let titleListView = TitleListView()
        titleListView.title = "Title"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: imageWithSubtitleListView)
    }
    
//    private func configureCurcleIconListViewCell() -> ListCell<ImageCardListView, TitleListView, CurcleIconListView> {
//        let curcleIconListView = CurcleIconListView()
//        curcleIconListView.image = Asset.Card.imageCardSmall.image
//        let titleListView = TitleListView()
//        titleListView.title = "Title"
//        let cardListView = ImageCardListView()
//        cardListView.cardImage = Asset.Card.visa.image
//        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: curcleIconListView)
//    }
    
}
