//
//  BaseCellViewController.swift
//  ExampleiOS
//
//  Created on 17.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class BaseCellViewController: ScrollViewController {
    
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
        navigationItem.title = "Base Cells"
        
        configureCells()
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureCells() {
        cells.append(configureTitleCell("Leading elements"))
        cells.append(configureTitleCell("Center elements"))
        cells.append(configureTitleCell("Trailing elements"))
        
        
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
        let cell: ListCell<ListCellEmpty, TitleListView, ArrowListView> = ListCell(centerView: titleListView, tralingView: ArrowListView())
        cell.centerOffset = LayoutGrid.doubleModule
        cell.trailingOffset = LayoutGrid.doubleModule
        return cell
    }
    
    @objc private func tapCell(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        
        switch view.tag {
        case 0:
            let vc = LeadingElementsViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = CenterElementsViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TralingElementsViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
