//
//  ActionItemBarViewTwo.swift
//  AdmiralUIKit
//
//  Created on 07.02.2022.
//

import UIKit
import AdmiralTheme

class ActionItemBarViewSecondary: UIControl, ActionBarViewPresentable, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = 90
        static let height: CGFloat = LayoutGrid.halfModule * 18
        static let textTopPadding: CGFloat = LayoutGrid.halfModule * 3
    }

    // MARK: - Internal Properties

    var tralingConstraint: NSLayoutConstraint?

    var scheme = ActionBarViewSecondaryScheme() {
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

    // MARK: - AccessibilitySupport

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Private Properties

    private var imageStyle: ActionBarItemImageStyle? = .accent {
        didSet { updateScheme() }
    }

    private var style: ActionBarItemStyle = .default {
        didSet { updateScheme() }
    }

    private let backGroundColor: UIColor?
    private let imageTintColor: UIColor?
    private let image: UIImage
    private let textLabel = UILabel()

    private var customAction: () -> Void
    private var text: String?
    private var iconImageView = UIImageView()

    // MARK: - Initializer

    required init(action: ActionItemBarAction) {
        self.image = action.image.withRenderingMode(.alwaysTemplate)
        self.customAction = action.handler
        self.imageStyle = action.imageStyle
        self.style = action.style
        self.imageTintColor = action.imageTintColor
        self.backGroundColor = action.backgroundColor
        self.text = action.text
        super.init(frame: .zero)
        accessibilityIdentifier = action.accesibilityId
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        self.scheme = ActionBarViewSecondaryScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func updateScheme() {
        configure(for: state)
        updateColors()
        updateFonts()
    }

    private func configure(for state: UIControl.State) {
        configureColors(for: state)
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }

    private func addSubviews() {
        [iconImageView, textLabel].addToSuperview(self)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.width),
            heightAnchor.constraint(equalToConstant: Constants.height),

            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.doubleModule),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }

    private func configureUI() {
        apply(theme: defaultTheme)

        textLabel.text = text
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = image

        isUserInteractionEnabled = true

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func tap() {
        customAction()
    }

    private func updateColors() {
        textLabel.textColor = scheme.textColor.uiColor
        configureColors(for: state)
    }

    private func configureColors(for state: UIControl.State = .normal) {
        switch (imageStyle, imageTintColor, backGroundColor) {
        case (nil, let tintColor, let frontColor):
            guard let tintColor = tintColor,
                  let frontColor = frontColor
            else {
                return
            }

            switch state {
            case .normal:
                iconImageView.tintColor = tintColor
                backgroundColor = frontColor
            default:
                iconImageView.tintColor = tintColor.withAlphaComponent(scheme.alpha)
                backgroundColor = frontColor.withAlphaComponent(scheme.alpha)
            }
        case (let imgStyle, nil, nil):
            guard let imageStyle = imgStyle else { return }

            backgroundColor = scheme.actionBarControl.backgroundColor.parameter(for: imageStyle, control: state)?.uiColor
            iconImageView.tintColor = scheme.imageTintColor.uiColor
            iconImageView.alpha = scheme.actionBarControl.imageViewAlpha.parameter(for: state) ?? 1.0
        default:
            break
        }
    }

    private func updateFonts() {
        textLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

}
