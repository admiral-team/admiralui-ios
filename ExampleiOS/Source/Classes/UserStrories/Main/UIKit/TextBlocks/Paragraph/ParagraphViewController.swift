//
//  ParagraphViewController.swift
//  ExampleiOS
//
//  Created on 18.07.2022.
//
// swiftlint:disable all

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class ParagraphViewController: ScrollViewController {
    
    var views: [ParagraphCellView] = []
    let titleLargeText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    var titleSmallText = "Lorem ipsum dolor sit amet"
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        views.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        stackView.spacing = LayoutGrid.halfModule * 3
        
        ceateParagraphCelView(titleText: "Primary", style: .primary)
        ceateParagraphCelView(titleText: "Secondary", style: .secondary)
        
        views.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func ceateParagraphCelView(titleText: String, style: ParagraphStyle) {
        let pointParagraph = Paragraph()
        pointParagraph.title = titleSmallText
        pointParagraph.paragraphStyle = style
        pointParagraph.paragraphType = .point
        views.append(ParagraphCellView(paragraph: pointParagraph, titleText: titleText))
        
        let checkParagraph = Paragraph()
        checkParagraph.title = titleSmallText
        checkParagraph.paragraphStyle = style
        checkParagraph.paragraphType = .check
        views.append(ParagraphCellView(paragraph: checkParagraph))
        
        let leftParagraph = Paragraph()
        leftParagraph.title = titleLargeText
        leftParagraph.paragraphStyle = style
        views.append(ParagraphCellView(paragraph: leftParagraph, heightParagraph: LayoutGrid.doubleModule * 5))
        
        let rightParagraph = Paragraph()
        rightParagraph.title = titleLargeText
        rightParagraph.paragraphStyle = style
        rightParagraph.traillingImage = Asset.Card.info.image
        views.append(ParagraphCellView(paragraph: rightParagraph, heightParagraph: LayoutGrid.doubleModule * 5))
        
        let centrLargeParagraph = Paragraph()
        centrLargeParagraph.title = titleLargeText
        centrLargeParagraph.textAligment = .center
        centrLargeParagraph.paragraphStyle = style
        views.append(ParagraphCellView(paragraph: centrLargeParagraph, heightParagraph: LayoutGrid.doubleModule * 5))
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({
            $0.setInformerState(isEnabled: control.selectedSegmentIndex == 1 ? false : true)
        })
    }
    
}
