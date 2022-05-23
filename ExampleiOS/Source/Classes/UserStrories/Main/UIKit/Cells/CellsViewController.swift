//
//  CellMenuViewController.swift
//  ExampleiOS
//
//  Created on 13.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class CellsViewController: ScrollViewController {
    
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
        navigationItem.title = "Cells"
        
        configureCells()
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureCells() {
        cells.append(configureTitleCell("Base Cells"))
        cells.append(configureTitleCell("ActionBar"))
        
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
        
        let listCell = ListCell<ListCellEmpty, TitleListView, ArrowListView>(centerView: titleListView,
                                                                             tralingView: ArrowListView())
        
        return listCell
    }
    
    @objc private func tapCell(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }

        switch view.tag {
        case 0:
            let vc = BaseCellViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ActionBarsViewController()
            vc.title = "Action Bars"
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
