//
//  ActionBaritemControl.swift
//  AdmiralUIResources
//
//  Created on 14.02.2022.
//

import UIKit
import AdmiralTheme

class ActionItemBarDefaultControl: UIControl, AnyAppThemable {

    // MARK: - Internal properties.

    var scheme = ActionItemBarDefaultControlScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private properties

    private var iconImageView = UIImageView()

    private var imageStyle: ActionBarItemImageStyle? = .accent {
        didSet { updateScheme() }
    }

    // MARK: - Override states

    /// A Boolean value indicating whether the control is in the selected state.
    open override var isSelected: Bool {
        didSet { updateScheme() }
    }

    /// A Boolean value indicating whether the control draws a highlight.
    open override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            super.isHighlighted = newValue
            updateScheme()
        }
    }

    /// A Boolean value indicating whether the control is in the enabled state.
    open override var isEnabled: Bool {
        didSet {
            updateScheme()
        }
    }

    // MARK: - Initializer

    init(
        style: ActionBarItemImageStyle?,
        image: UIImage,
        accessibilityId: String? = nil
    ) {
        super.init(frame: .zero)
        self.imageStyle = style
        self.iconImageView.image = image
        accessibilityIdentifier = accessibilityId
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        layer.cornerRadius = LayoutGrid.doubleModule
        clipsToBounds = true
        isUserInteractionEnabled = true
        iconImageView.contentMode = .scaleAspectFit
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        self.scheme = ActionItemBarDefaultControlScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
        configureUI()
        updateColors()
    }

    private func addSubviews() {
        [iconImageView].addToSuperview(self)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            heightAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),

            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: LayoutGrid.module),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: LayoutGrid.module)
        ])
    }

    private func updateScheme() {
        configure(for: state)
        updateColors()
    }

    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        iconImageView.alpha = scheme.imageViewAlpha.parameter(for: state) ?? 1.0
    }

    private func updateColors() {
        guard let imageStyle = imageStyle else { return }

        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        iconImageView.tintColor = scheme.imageTintColor.parameter(for: imageStyle, control: state)?.uiColor
    }

}


