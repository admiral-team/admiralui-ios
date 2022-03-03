//
//  TitleBaseCellViewController.swift
//  ExampleiOS
//
//  Created on 24.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class TitleBaseCellViewController: ScrollViewController {
    
    var cells: [ListViewCell] = []
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        cells.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        navigationItem.title = "Title Cell"
        
        configureCells()
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureCells() {
        cells.append(configureTitleCell("Primary"))
        cells.append(configureTitleCell("Second"))
        
        
        for index in 0..<cells.count {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapCell(_:)))
            cells[index].isUserInteractionEnabled = true
            cells[index].addGestureRecognizer(gesture)
            cells[index].tag = index
        }
    }
    
    private func configureTitleCell(_ title: String?) -> ListCell<ListCellEmpty, TitleListView, ArrowListView> {
        let titleListView = TitleListView()
        titleListView.title = title
        return ListCell(centerView: titleListView, tralingView: ArrowListView())
    }
    
    @objc private func tapCell(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        
        switch view.tag {
        case 0:
            let vc = PrimaryTitleCellViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = SecondaryTitleCelViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
