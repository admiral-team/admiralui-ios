//
//  ThemeInfoHeaderView.swift
//  ExampleiOS
//
//  Created on 20.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ThemeInfoHeaderView: UIView, AnyAppThemable {
    
    let infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        autoManage()
        
        [infoLabel].addToSuperview(self)
        infoLabel.fillView(
            view: self,
            padding: DirectionalEdgeInsets(
                top: LayoutGrid.module * 3,
                bottom: LayoutGrid.doubleModule,
                leading: LayoutGrid.doubleModule,
                trailing: LayoutGrid.module * 3)
        ).activate()
    }
    
    func apply(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic.uiColor
        infoLabel.textColor = theme.colors.textPrimary.uiColor
        infoLabel.setDynamicFont(
            font: theme.fonts.body2.uiFont,
            textStyle: theme.fonts.body2.textStyle)
    }
    
}
