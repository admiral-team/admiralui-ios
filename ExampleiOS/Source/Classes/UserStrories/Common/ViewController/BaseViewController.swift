//
//  BaseViewController.swift
//  ExampleiOS
//
//  Created on 06.04.2021.
//

//
//  BaseTableViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class BaseViewController: UIViewController, UITableViewDelegate, AnyAppThemable {
    
    let themeSwitchView = ThemeSwitchView()
        
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()        
        configureUI()
    }
    
    private func configureUI() {
        addThemeSwitchView(themeSwitchView)
    }
    
}
