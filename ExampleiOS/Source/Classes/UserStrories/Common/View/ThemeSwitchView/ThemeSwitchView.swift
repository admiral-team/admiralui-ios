//
//  ThemeSwitchView.swift
//  ExampleiOS
//
//  Created on 12.07.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIKit

protocol ThemeSwitchViewDelegate: AnyObject {
    func didTap(_ view: ThemeSwitchView?)
    func didSelect(_ view: ThemeSwitchView?, at index: Int)
    func shouldShowMenu(_ view: ThemeSwitchView) -> Bool
}

protocol ThemeSwitchViewDataSource: AnyObject {
    var selectedIndex: Int? { get }
    func items(_ view: ThemeSwitchView) -> [ThemeSwitchComponentView]
}

final class ThemeSwitchView: UIView, AppThemeable, ThemeSwitchListViewDelegate, ThemeSwitchListViewDataSource {
    
    weak var delegate: ThemeSwitchViewDelegate?
    weak var dataSource: ThemeSwitchViewDataSource?
    var sizeChange: ((CGSize) -> Void)?
    
    private let coordinator = ThemeSwitchViewCoordinator()
    
    private let button = ThemeSwitchButton()
    private let listView = ThemeSwitchListView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sizeChange?(frame.size)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func reloadData() {
        listView.reloadData()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        backgroundColor = .clear
        button.apply(theme: theme)
        listView.apply(theme: theme)
    }
    
    // MARK: - ThemeSwitchListViewDelegate
    
    func didSelectItem(_ view: ThemeSwitchListView, at index: Int) {
        delegate?.didSelect(self, at: index)
    }
    
    // MARK: - ThemeSwitchViewDataSource
    
    func selectedIndex(_ view: ThemeSwitchListView) -> Int? {
        dataSource?.selectedIndex
    }
    
    func items(_ view: ThemeSwitchListView) -> [ThemeSwitchComponentView] {
        dataSource?.items(self) ?? []
    }
    
    private func commonInit() {
        delegate = coordinator
        dataSource = coordinator

        listView.delegate = self
        listView.dataSource = self
        
        stackView.axis = .vertical
        stackView.alignment = .trailing
        
        listView.isHidden = true
        
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        [stackView].addToSuperview(self)
        stackView.addArrangedSubview(listView)
        stackView.addArrangedSubview(button)
        
        stackView.spacing = LayoutGrid.doubleModule
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let top = stackView.topAnchor.constraint(equalTo: self.topAnchor)
        top.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 7),
            button.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 7),
            
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            top,
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    @objc private func didTap() {
        let shouldShowMenu = delegate?.shouldShowMenu(self) ?? false
        
        if shouldShowMenu {
            reloadData()
            button.isSelected = !button.isSelected
            listView.isHidden = !button.isSelected
        } else {
            button.isSelected = false
            listView.isHidden = true
            delegate?.didTap(self)
        }

        setNeedsLayout()
        layoutIfNeeded()
    }
    
}
