//
//  PrimaryTitleCellViewController.swift
//  ExampleiOS
//
//  Created on 24.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class PrimaryTitleCellViewController: ScrollViewController {
    
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
        navigationItem.title = "Primary Title Cell"
        
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
        cells.append(configurePrimaryCell("Title"))
    
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
    
    private func configurePrimaryCell(_ title: String?) -> ListCell<ListCellEmpty, TitleWithArrowListView, ButtonListView> {
        let buttonListView = ButtonListView()
        buttonListView.title = "Button"
        buttonListView.didSelect = {
            print("Did select")
        }
        buttonListView.accessibilityIdentifier = "ButtonListView"
        buttonListView.buttonAccesibilityId = "ButtonListViewButton"
        let titleWithArrowListView = TitleWithArrowListView()
        titleWithArrowListView.title = title
        return ListCell(centerView: titleWithArrowListView, tralingView: buttonListView)
    }
    
}
