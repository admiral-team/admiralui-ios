//
//  ImageBaseCell.swift
//  ExampleiOS
//
//  Created on 20.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ImageBaseCellViewController: ScrollViewController {
    
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
        navigationItem.title = "Base Cells vs Image"
        
        configureCells()
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureCells() {
        cells.append(configureTitleCell("Image"))
        cells.append(configureTitleCell("Leading Elements"))
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
        
        return ListCell(centerView: titleListView, tralingView: ArrowListView())
    }
    
    @objc private func tapCell(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        
        switch view.tag {
        case 0:
            let vc = ImageBaseCellDetailViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ImageBaseCellLeadingViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = ImageBaseCellTralingViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
