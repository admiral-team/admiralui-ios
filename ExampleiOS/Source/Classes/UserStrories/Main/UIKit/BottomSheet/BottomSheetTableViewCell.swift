//
//  BottomSheetTableViewCell.swift
//  ExampleiOS
//
//  Created on 24.12.2020.
//

import AdmiralTheme
import AdmiralUIKit
import UIKit


class BottomSheetTableViewCellViewModel {
    let title: String
    let subtitle: String
    let image: UIImage
    let additionalTitle: String?
    var isSelected: Bool
    
    init(title: String, isSelected: Bool, subtitle: String, additionalTitle: String?, image: UIImage) {
        self.title = title
        self.isSelected = isSelected
        self.subtitle = subtitle
        self.image = image
        self.additionalTitle = additionalTitle
    }
}

final class BottomSheetTableViewCell: TableListCell<LeadingCardListView, TitleLargeSubtitleListView, CheckBoxListView> {
    
    // MARK: - Private Properties
    
    private let checkBoxCell = CheckBoxListView()
    private let titleListView = TitleLargeSubtitleListView()
    private let cardListView = LeadingCardListView()
    
    // MARK: - Initializers
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AppThemeable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        checkBoxCell.backgroundColor = theme.colors.backgroundExtraSurface.uiColor
        titleListView.backgroundColor = theme.colors.backgroundExtraSurface.uiColor
        cardListView.backgroundColor = theme.colors.backgroundExtraSurface.uiColor
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        selectionStyle = .none
        listCell = ListCell(
            leadingView: cardListView,
            centerView: titleListView,
            tralingView: checkBoxCell)
        
        autoManage()
    }
    
    func configureWith(model: BottomSheetTableViewCellViewModel) {
        titleListView.title = model.title
        titleListView.additionalTitle = model.additionalTitle
        isSelected = model.isSelected
        titleListView.subtitle = model.subtitle
        cardListView.cardImage = model.image
        checkBoxCell.isSelected = model.isSelected
    }
    
}
