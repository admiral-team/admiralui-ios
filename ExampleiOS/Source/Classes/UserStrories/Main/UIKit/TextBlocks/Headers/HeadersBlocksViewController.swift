//
//  HeadersViewController.swift
//  ExampleiOS
//
//  Created on 22.02.2022.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class HeadersBlocksViewController: ScrollViewController {

    // MARK: - Private Properties

    private let viewModel = HeadersBlockViewModel()

    // MARK: - Internal Properties

    var headers: [UIView] = []
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        headers.forEach({ ($0 as? AppThemeCompatible)?.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        stackView.spacing = LayoutGrid.halfModule * 3

        viewModel.items.forEach {
            configureHeaderViews(title: $0.title, headerStyle: $0.headerStyle)
        }

        headers.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureHeaderViews(title: String, headerStyle: HeaderStyle) {
        headers.append(configureTitleCell(title))
        headers.append(TitleHeader(title: "Title", textAligment: .left, headerStyle: headerStyle))
        headers.append(DropDownHeader(title: "Title", dropDownHeaderType: .down, headerStyle: headerStyle))
        headers.append(SubtitleTitleHeader(title: "Title", subtitle: "Subtitle", headerStyle: headerStyle))
        headers.append(TitleSubtitleHeader(title: "Title", subtitle: "Subtitle", headerStyle: headerStyle))
        headers.append(ArrowWithButtonHeader(title: "Title", buttonTitle: "Button", dropDownHeaderType: .down, headerStyle: headerStyle))
        headers.append(TitleHeader(title: "Title", textAligment: .center, headerStyle: headerStyle))
    }
    
    private func configureTitleCell(_ title: String?) -> ListCell<ListCellEmpty, SecondaryTitleListView, ListCellEmpty> {
        let secondaryTitleListView = SecondaryTitleListView()
        secondaryTitleListView.title = title
        return ListCell(centerView: secondaryTitleListView)
    }
    
}
