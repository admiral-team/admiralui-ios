//
//  ImageBaseCellDetailViewController.swift
//  ExampleiOS
//
//  Created on 20.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class LeadingElementsViewController: ScrollViewController {
    
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
        navigationItem.title = "Leading elements"
        
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(changeSegment(_:)), for: .valueChanged)
        
        configureCells()
        
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
        cells.append(configureCardCell())
        cells.append(configureLargeImageCell())
        cells.append(configureImageNameListViewCell())
        cells.append(configureImageBackgroundListViewCell())
        cells.append(configureImageCell())
        
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
    
    private func configureCardCell() -> ListCell<LeadingCardListView, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Card Place"
        let cardListView = LeadingCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        let cell = ListCell(leadingView: cardListView, centerView: titleListView, tralingView: ArrowListView())
        cell.accessibilityIdentifier = "CardCell"
        return cell
    }

    private func configureLargeImageCell() -> ListCell<ImageListView, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Label Place"
        let iconListView = ImageListView()
        iconListView.image = Asset.Card.rnb.image
        let cell = ListCell(leadingView: iconListView, centerView: titleListView, tralingView: ArrowListView())
        cell.accessibilityIdentifier = "LargeImageCell"
        return cell
    }

    private func configureImageCell() -> ListCell<ImageListView, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Icon Place"
        let iconListView = ImageListView()
        iconListView.image = Asset.Main.gem.image
        let cell = ListCell(leadingView: iconListView, centerView: titleListView, tralingView: ArrowListView())
        cell.accessibilityIdentifier = "ImageCell"
        return cell
    }
    
    private func configureImageBackgroundListViewCell() -> ListCell<ImageBackgroundListView, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Icon Place vs Background"
        let iconListView = ImageBackgroundListView()
        iconListView.image = Asset.Main.gem.image
        let cell = ListCell(leadingView: iconListView, centerView: titleListView, tralingView: ArrowListView())
        cell.accessibilityIdentifier = "ImageBackgroundListViewCell"
        return cell
    }
    
    private func configureImageNameListViewCell() -> ListCell<ImageNameListView, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = "Icon Name"
        let imageNameListView = ImageNameListView()
        imageNameListView.text = "IN"
        let cell = ListCell(leadingView: imageNameListView, centerView: titleListView, tralingView: ArrowListView())
        cell.accessibilityIdentifier = "ImageNameListViewCell"
        return cell
    }
    
    
}
