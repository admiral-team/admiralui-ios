//
//  BigTabsView.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit
 
final class BigTabsView<T>: UIView, AnyAppThemable, AccessibilitySupport where T: UIControl {
    
    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            informer.isEnabled = isEnabled
            segmentView.isEnabled = isEnabled
        }
    }

    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private var segmentView: UIControl
    private let informer: MessageInformer = {
        let informer = MessageInformer()
        informer.titleText = "то получу в страховом случае"
        informer.descriptionText = "до 1 500 000 Р"
        informer.subtitleText = "Выгодный вариант для двухкомнатной квартиры или дачного дома"
        return informer
    }()
    private let segmentViewLeadingTralinlingOffest: CGFloat = LayoutGrid.doubleModule
    private var scheme = BigTabsViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(segmentView: T, title: String) {
        titleLabel.text = title
        self.segmentView = segmentView
        super.init(frame: .zero)
        
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let control = segmentView as? InformerTabSegmentedControl else { return }
        
        let step = calculateStep(control: control)
        informer.setArrowPivotLeadingAnchorPoint(constant: step, animated: false)
    }
    
    @objc private func segmentedValueChanged(_ control: InformerTabSegmentedControl) {
        let step = calculateStep(control: control)
        informer.setArrowPivotLeadingAnchorPoint(constant: step)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        informer.apply(theme: theme)
        (segmentView as? AppThemeCompatible)?.apply(theme: theme)
        scheme = BigTabsViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        configureLabel()
        setupConstraits()
        setupSegmentControl()
    }
    
    private func setupSegmentControl() {
        segmentView.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func addSubviews() {
        [titleLabel,
         informer,
         segmentView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }

    private func configureLabel() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
            
            segmentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            segmentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: segmentViewLeadingTralinlingOffest),
            trailingAnchor.constraint(equalTo: segmentView.trailingAnchor, constant: segmentViewLeadingTralinlingOffest),
            
            informer.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: LayoutGrid.doubleModule),
            informer.leadingAnchor.constraint(equalTo: leadingAnchor),
            informer.trailingAnchor.constraint(equalTo: trailingAnchor),
            informer.heightAnchor.constraint(equalToConstant: 182),
            bottomAnchor.constraint(equalTo: informer.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func calculateStep(control: InformerTabSegmentedControl) -> CGFloat {
        let distanceBetweenSegments = LayoutGrid.module
        let numberOfSegment = CGFloat(control.numberOfSegments)
        let segmentWidth = (control.frame.width - (distanceBetweenSegments * (numberOfSegment - 1))) / numberOfSegment
        let step = segmentViewLeadingTralinlingOffest
            + (segmentWidth / 2)
            + ((segmentWidth + distanceBetweenSegments) * CGFloat(control.selectedSegmentIndex))
            - distanceBetweenSegments
        return step
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
}
