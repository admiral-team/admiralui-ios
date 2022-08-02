//
//  TextBlocksViewController.swift
//  ExampleiOS
//
//  Created on 22.02.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class TextBlocksViewController: ScrollViewController {
    
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
        configureCells()
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureCells() {
        cells.append(configureTitleCell("Header"))
        cells.append(configureTitleCell("Accordion"))
        cells.append(configureTitleCell("Paragraph"))
        cells.append(configureTitleCell("Link"))
        cells.append(configureTitleCell("Padding"))
        
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
            let vc = HeadersBlocksViewController()
            vc.title = "Header"
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = DropDownViewController()
            vc.title = "Accordion"
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = ParagraphViewController()
            vc.title = "Paragraph"
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = LinksHeaderViewController()
            vc.title = "Link"
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = SeparatorViewController()
            vc.title = "Padding"
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
