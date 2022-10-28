//
//  ImageBaseCellLeadingViewController.swift
//  ExampleiOS
//
//  Created on 20.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ImageBaseCellLeadingViewController: ScrollViewController {
    
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
        navigationItem.title = "Leading Cell"
        
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
        cells.append(configureTitleCell("Title"))
        cells.append(configureTitleSubtitleCell("Title", subtitle: "Subtitle"))
        cells.append(configureSubtitleTitleCell("Title", subtitle: "Subtitle"))
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
    
    private func configureTitleCell(_ title: String?) -> ListCell<LeadingCardListView, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = title
        let cardListView = LeadingCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleListView, tralingView: ArrowListView())
    }
    
    private func configureTitleSubtitleCell(_ title: String?, subtitle: String?) -> ListCell<LeadingCardListView, TitleSubtitleListView, ArrowListView> {
        let titleSubtitleListView = TitleSubtitleListView()
        titleSubtitleListView.title = title
        titleSubtitleListView.subtitle = subtitle
        let cardListView = LeadingCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: titleSubtitleListView, tralingView: ArrowListView())
    }
    
    private func configureSubtitleTitleCell(_ title: String?, subtitle: String?) -> ListCell<LeadingCardListView, SubtitleTitleListView, ArrowListView> {
        let subtitleTitleListView = SubtitleTitleListView()
        subtitleTitleListView.title = title
        subtitleTitleListView.subtitle = subtitle
        let cardListView = LeadingCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: subtitleTitleListView, tralingView: ArrowListView())
    }
    
    private func configureTitleMoreDetaileTextMessageListView() -> ListCell<LeadingCardListView, TitleMoreDetailTextMessageListView, ArrowListView> {
        let leftView = TitleMoreDetailTextMessageListView()
        leftView.title = "Title"
        leftView.more = "More"
        leftView.subtitle = "Subtitle"
        leftView.detaileMore = "More"
        leftView.detaile = "Detail"
        leftView.tagText = "Tag"
        leftView.messageText = "Message"
        let cardListView = LeadingCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: leftView, tralingView: ArrowListView())
    }
    
    private func configureTitleSubtitleButtonListView() -> ListCell<LeadingCardListView, TitleSubtitleButtonListView, ArrowListView> {
        let leftView = TitleSubtitleButtonListView()
        leftView.title = "Title"
        leftView.subtitle = "Subtitle 2"
        leftView.tagText = "Tag"
        leftView.tagSubtitle = "Subtitle"
        leftView.buttonTitle = "Button"
        leftView.didSelect = {
            print("Select")
        }
        let cardListView = LeadingCardListView()
        cardListView.cardImage = Asset.Card.visa.image
        return ListCell(leadingView: cardListView, centerView: leftView, tralingView: ArrowListView())
    }
    
}
