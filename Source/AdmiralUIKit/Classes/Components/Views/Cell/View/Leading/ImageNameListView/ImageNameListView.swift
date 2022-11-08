//
//  ImageNameListView.swift
//  AdmiralUI
//
//  Created on 20.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// A view object with background view and image view.
public class ImageNameListView: BaseListView, LeadingListViewComponent, AnyAppThemable {
    
    enum Constants {
        static let nameBackgroundViewHeight: CGFloat = LayoutGrid.halfModule * 11
    }
    
    // MARK: - Public Properties
    
    /// The text displayed in the text label.
    public var text: String? {
        didSet { titleLabel.text = text }
    }

    /// Color scheme.
    public var scheme = ImageNameListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let backgroundNameView = UIView()
    
    private var viewBackgroundColor = ControlParameter<AColor>()
    private var backgroundNameViewColor = ControlParameter<AColor>()
    private var titleLabelTextColor = ControlParameter<AColor>()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = ImageNameListViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle)
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        backgroundNameView.backgroundColor = scheme.backgroundNameViewColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [backgroundNameView].addToSuperview(self)
        [titleLabel].addToSuperview(backgroundNameView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: backgroundNameView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundNameView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundNameView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundNameView.trailingAnchor),
            
            backgroundNameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            backgroundNameView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundNameView.widthAnchor.constraint(equalToConstant: Constants.nameBackgroundViewHeight),
            backgroundNameView.heightAnchor.constraint(equalToConstant: Constants.nameBackgroundViewHeight)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        
        backgroundNameView.clipsToBounds = true
        backgroundNameView.layer.cornerRadius = Constants.nameBackgroundViewHeight / 2
    }
    
}
