//
//  ErrorView.swift
//  AdmiralUIKit
//
//  Created on 16.02.2022.
//

import AdmiralTheme
import UIKit

/// The protocol that describes communication with ErrorView.
public protocol ErrorViewDelegate: AnyObject {
    /// Did tap button event.
    func didTapButton(_ errorView: ErrorView)
}

/**
 ErrorView - the component is used to attract the user's attention as a message.

 You can create a ErrorView with the zero frame rectangle by specifying the following parameters in init:

 - text: String - Information text
 - buttonTitle: String - Title for the button
 - isLoading: Bool - The loading flag of GhostButton. Activates when flag sets to true and dissapier when flag sets to false.

 ## Example to create ErrorView
 # Code
 ```
 let errorView = ErrorView()
 errorView.text = "button"
 errrorView.action = {}
```
 */
public final class ErrorView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let buttonPaddingTop: CGFloat = LayoutGrid.module * 8
    }

    // MARK: - Public properties

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    /// Color scheme.
    public var scheme = ErrorViewScheme() {
        didSet { updateScheme() }
    }

    /// The button title.
    public var buttonTitle: String? {
        didSet {
            ghostButton.setTitle(buttonTitle, for: .normal)
        }
    }

    /// The text of label.
    public var text: String? {
        didSet {
            updateStackSpacing()
        }
    }

    /// The loading flag of GhostButton. Activates when flag sets to true and dissapier when flag sets to false.
    public var isLoading: Bool = false {
        didSet {
            ghostButton.isLoading = isLoading
        }
    }

    /// The ghost button accessibility id
    public var ghostButtonAccesibilityId: String? {
        didSet {
            ghostButton.accessibilityIdentifier = ghostButtonAccesibilityId
        }
    }

    /// The delegate of ErrorView.
    weak public var delegate: ErrorViewDelegate? = nil

    // MARK: - Private properties

    private let textLabel = UILabel()
    private let ghostButton = GhostButton()

    private lazy var textBlockStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = Constants.buttonPaddingTop
        return stackView
    }()

    // MARK: - Initializer

    init(text: String, buttonTitle: String) {
        self.text = text
        self.buttonTitle = buttonTitle
        super.init(frame: CGRect())
    }

    convenience public init() {
        self.init(frame: CGRect())
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Public Methods

    public func apply(theme: AppTheme) {
        scheme = ErrorViewScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
        setupUI()
    }

    private func addSubviews() {
        [textBlockStackView].addToSuperview(self)
        textBlockStackView.addArrangedSubview(textLabel)
        textBlockStackView.addArrangedSubview(ghostButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textBlockStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            textBlockStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textBlockStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: textBlockStackView.trailingAnchor, constant: LayoutGrid.doubleModule)
        ])
    }

    private func setupUI() {
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .center
        ghostButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func updateStackSpacing() {
        textLabel.text = text
        guard let text = text,
              text.count > 0
        else {
            textBlockStackView.spacing = .zero
            return
        }

        textBlockStackView.spacing = Constants.buttonPaddingTop
    }

    @objc private func buttonTapped(sender: UIButton) {
        delegate?.didTapButton(self)
    }

    private func updateScheme() {
        updateFonts()
        updateColors()
    }

    private func updateFonts() {
        textLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

    private func updateColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        textLabel.textColor = scheme.titleColor.uiColor
        ghostButton.scheme = scheme.ghostButtonScheme
    }

}
