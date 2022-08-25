//
//  CalendarViewCell.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit
import AdmiralTheme

struct CalendarDayItem {
    let title: String
    let isDisplayedInMonth: Bool
    let isSelected: Bool
    let isTail: Bool
    let isCurrentDay: Bool
    var isActive: Bool = true
    var hasPoint: Bool = false
}

/// The style of calendar cell.
enum CalendarCellState: UInt {
    case normal
    case tailSelected
    case selected
    case currentDate
    case disabled
}

class CalendarDayCell: UICollectionViewCell, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        static let wrapViewBorderWidth: CGFloat = LayoutGrid.halfModule / 2
        static let wrapViewBorderCornerRadius: CGFloat = LayoutGrid.halfModule
    }
    
    // MARK: - Public Properties
    
    var scheme = CalendarViewCellColorScheme() {
        didSet { updateScheme()  }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties

    private let wrapView = UIView()
    private let titleLabel = UILabel()
    private let pointView = UIView()
    
    private var isDisplayedInMonth: Bool = false {
        didSet { updateBorderWidth() }
    }

    private var state: CalendarCellState = .normal {
        didSet { updateScheme()  }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods

    func configureWith(model: CalendarDayItem) {
        titleLabel.text = model.title
        titleLabel.isHidden = model.isDisplayedInMonth ? false : true
        
        state = model.isCurrentDay ? .currentDate : .normal

        if model.isSelected {
            state = model.isTail ? .tailSelected : .selected
        }
        if !model.isActive {
            state = .disabled
        }
        
        isDisplayedInMonth = model.isDisplayedInMonth
        
        pointView.isHidden = !(model.hasPoint && isDisplayedInMonth)
    }
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = CalendarViewCellColorScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupViews()
        setupLabels()
        configureConstraints()
    }
    
    private func addSubviews() {
        [wrapView, pointView].addToSuperview(contentView)
        wrapView.addSubview(titleLabel)
    }
    
    private func setupViews() {
        wrapView.clipsToBounds = true
        wrapView.layer.cornerRadius = Constants.wrapViewBorderCornerRadius
        
        pointView.clipsToBounds = true
        pointView.layer.cornerRadius = LayoutGrid.halfModule / 2
        
        updateBorderWidth()
    }
    
    private func setupLabels() {
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            wrapView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 9),
            wrapView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 9),
            wrapView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule),
            wrapView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: wrapView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: wrapView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: LayoutGrid.halfModule / 2),
            wrapView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.halfModule / 2),
            
            pointView.topAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: LayoutGrid.halfModule / 2),
            pointView.centerXAnchor.constraint(equalTo: wrapView.centerXAnchor),
            pointView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule),
            pointView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
        updateBorderWidth()
    }
    
    private func updateBorderWidth() {
        let isCurrentDate = state == .currentDate
        wrapView.layer.borderWidth = isDisplayedInMonth && isCurrentDate ? Constants.wrapViewBorderWidth : 0
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        wrapView.backgroundColor = scheme.selectedBackgroundColors.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.textColors.parameter(for: state)?.uiColor
        wrapView.layer.borderColor = scheme.borderColors.parameter(for: state)?.cgColor
        pointView.backgroundColor = scheme.pointBackgroundColor.uiColor
        backgroundColor = scheme.backgroundColors.parameter(for: state)?.uiColor
    }

}
