//
//  ThemeSwitchCollectionView.swift
//  ExampleiOS
//
//  Created on 23.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

protocol ThemeSwitchListViewDelegate: AnyObject {
    func didSelectItem(_ view: ThemeSwitchListView, at index: Int)
}

protocol ThemeSwitchListViewDataSource: AnyObject {
    func selectedIndex(_ view: ThemeSwitchListView) -> Int?
    func items(_ view: ThemeSwitchListView) -> [ThemeSwitchComponentView]
}

final class ThemeSwitchListView: UIControl, AnyAppThemable {
    
    // MARK: - Public Properties
    
    var selectedSegmentIndex: Int {
        get { return selectedIndex }
        set { setSelectView(newValue) }
    }
    
    weak var delegate: ThemeSwitchListViewDelegate?
    weak var dataSource: ThemeSwitchListViewDataSource?
        
    override var intrinsicContentSize: CGSize {
        return calculateContentSize()
    }
   
    // MARK: - Private Properties
    
    private enum Constants {
        static let stackViewOffset: CGFloat = 10.0
        static let stackViewSpacing: CGFloat = LayoutGrid.halfModule * 3
        static let containerViewOffset: CGFloat = LayoutGrid.doubleModule
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = Constants.stackViewSpacing
        
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.canCancelContentTouches = true
        scrollView.delaysContentTouches = true
        scrollView.alwaysBounceHorizontal = false

        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        
        return view
    }()
    
    private var contentSize: CGSize = .zero
    
    private var selectedIndex: Int = 0
    private var items: [ThemeSwitchComponentView] = []
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 28.0
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scrollView.backgroundColor = UIColor.clear
        containerView.backgroundColor = theme.colors.backgroundExtraSurface.uiColor
        
        layer.shadowColor = theme.colors.backgroundShadow.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.0, height: LayoutGrid.halfModule)
        layer.shadowRadius = LayoutGrid.module
    }
        
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureLayout()
        reloadData()
    }
    
    private func calculateContentSize() -> CGSize {
        let itemsWidth = stackView.arrangedSubviews.map({ $0.intrinsicContentSize.width }).reduce(0, +)
        let stackViewWidth = itemsWidth + CGFloat((stackView.arrangedSubviews.count - 1)) * Constants.stackViewSpacing
        let width = (Constants.stackViewOffset * 2) + stackViewWidth + (Constants.containerViewOffset * 2)
        
        return CGSize(width: width, height: LayoutGrid.module * 7)
    }
    
    private func addSubviews() {
        [containerView].addToSuperview(self)
        [scrollView].addToSuperview(containerView)
        [stackView].addToSuperview(scrollView)
    }
    
    private func configureLayout() {
        stackView.alignment = .center
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
    
    func reloadData() {
        items = dataSource?.items(self) ?? []
        
        stackView.arrangedSubviews.forEach({
            $0.removeFromSuperview()
            stackView.removeArrangedSubview($0)
        })
 
        items.enumerated().forEach() {
            prepare(view: $0.element, index: $0.offset)
            stackView.addArrangedSubview($0.element)
        }
        
        items.enumerated().forEach() {
            $0.element.tag = $0.offset
        }
        
        invalidateIntrinsicContentSize()
        
        let xInset = Constants.containerViewOffset
        let contentInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
        scrollView.contentInset = contentInset
        
        setSelectedView()
    }
    
    private func createItem(title: String?) -> ThemeSwitchComponentView {
        let item = ThemeSwitchComponentView()
        item.title = title

        return item
    }
    
    private func prepare(view: UIControl, index: Int) {
        view.addTarget(self, action: #selector(tapSegment(_:)), for: .touchUpInside)
        view.tag = index
    }
    
    private func setSelectView(_ index: Int) {
        selectedIndex = index
        sendActions(for: UIControl.Event.valueChanged)
        
        for i in 0..<items.count {
            configure(view: items[i], index: i)
        }
    }
    
    private func configure(view: ThemeSwitchComponentView, index: Int) {
        let isSelected = index == selectedIndex
        view.isSelected = isSelected
    }
    
    private func setSelectedView() {
        setSelectView(dataSource?.selectedIndex(self) ?? 0)
    }
    
    @objc private func tapSegment(_ control: UIControl) {
        selectedIndex = control.tag
        setSelectView(selectedIndex)
        sendActions(for: UIControl.Event.valueChanged)
        delegate?.didSelectItem(self, at: selectedIndex)
    }
    
}
