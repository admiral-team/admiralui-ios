//
//  ScrollViewController.swift
//  Example iOS
//
//  Created by APolyakov on 14.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class ScrollViewController: UIViewController, AnyAppThemable {
    
    private enum Constants {
        static let segmentViewHeight: CGFloat = 48.0
    }
    
    // MARK: - Pulic Propeties
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset.bottom = LayoutGrid.module * 9
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        return stackView
    }()
    
    lazy var segmentControl = StandardSegmentedControl(frame: .zero)
    lazy var outlineSegmentControl = OutlineSliderTabSegmentedControl(frame: .zero)
    
    var isThemeSwitchViewHidden: Bool {
        get { themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }
    
    // MARK: - Private Properties
    
    private lazy var stackViewTopConstraint: NSLayoutConstraint = {
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.segmentViewHeight)
    }()
    
    private let themeSwitchView = ThemeSwitchView(frame: .zero)
    
    // MARK: - Pulic Methods
        
    override func loadView() {
        super.loadView()
        hideSegmentView(true)
        hideOutlineSegment(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        outlineSegmentControl.apply(theme: theme)
        segmentControl.apply(theme: theme)
        scrollView.backgroundColor = theme.colors.backgroundBasic.uiColor
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
    }
    
    func hideSegmentView(_ state: Bool) {
        segmentControl.isHidden = state
        stackViewTopConstraint.constant = state ? 0 : Constants.segmentViewHeight
    }
    
    func hideOutlineSegment(_ state: Bool) {
        outlineSegmentControl.isHidden = state
        stackViewTopConstraint.constant = state ? 0 : Constants.segmentViewHeight
    }
    
    func refreshTheme() {
        apply(theme: Appearance.shared.theme)
    }
    
    // MARK: - Private Methods
    
    private func configureLayout() {
        autoManage()
        addSubviews()
        configureScrollViewLayout()
        configureStackViewLayout()
        
        addThemeSwitchView(themeSwitchView)
    }
    
    private func addSubviews() {
        [scrollView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
         })
        
        [stackView,
         segmentControl,
         outlineSegmentControl].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
         })
    }
    
    private func configureScrollViewLayout() {
        NSLayoutConstraint.activate(scrollView.fillView(view: view))
    }
    
    private func configureStackViewLayout() {
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: LayoutGrid.module),
            segmentControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: LayoutGrid.doubleModule),
            scrollView.trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.heightAnchor.constraint(equalToConstant: Constants.segmentViewHeight),
            
            outlineSegmentControl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: LayoutGrid.doubleModule),
            outlineSegmentControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: LayoutGrid.doubleModule),
            scrollView.trailingAnchor.constraint(equalTo: outlineSegmentControl.trailingAnchor, constant: LayoutGrid.doubleModule),
            outlineSegmentControl.heightAnchor.constraint(equalToConstant: Constants.segmentViewHeight),
            
            stackViewTopConstraint,
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    @objc private func tapThemeSwitchButton(_ button: UIButton) {
        themeSwitchView.setIsHidden(!button.isSelected, animated: true)
        
        if !themeSwitchView.isHidden {
            themeSwitchView.reloadData()
        }
    }

}
