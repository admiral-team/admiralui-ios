//
//  StatusHistoryViewController.swift
//  ExampleiOS
//
//  Created on 22.12.2020.
//

import AdmiralUIKit
import UIKit

final class StatusHistoryViewController: ScrollViewController {
    
    var cells: [UIView] = []
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureCells()
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureCells() {
        cells.append(configureTitleCell("Standard"))
        cells.append(configureTitleCell("Small"))
        
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
            let vc = StatusHistoryStandardViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = StatusHistorySmallViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
