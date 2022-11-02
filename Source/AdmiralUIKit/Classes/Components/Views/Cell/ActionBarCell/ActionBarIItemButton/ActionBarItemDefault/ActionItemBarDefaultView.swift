//
//  ActionItemBarView.swift
//  AdmiralUI
//
//  Created on 02.12.2020.
//

import UIKit
import AdmiralTheme

class ActionItemBarDefaultView: UIView, ActionBarViewPresentable, AnyAppThemable {

    // MARK: - Internal Properties

    var tralingConstraint: NSLayoutConstraint?

    var scheme = ActionItemBarDefaultViewScheme() {
        didSet { updateScheme() }
    }

    var isEnabled: Bool {
        get { !state.contains(.disabled) }
        set {
            if newValue {
                state.remove(.disabled)
            } else {
                state.insert(.disabled)
            }
            backgroundControlView.isEnabled = isEnabled
        }
    }

    // MARK: - Private Properties

    private var state: UIControl.State = .normal {
        didSet { configure(for: state) }
    }

    private var customAction: () -> Void
    private var backgroundControlView: ActionItemBarDefaultControl

    // MARK: - Initializer

    init(action: ActionItemBarAction) {
        self.customAction = action.handler
        backgroundControlView = ActionItemBarDefaultControl(
            style: action.imageStyle,
            image: action.image.withRenderingMode(.alwaysTemplate),
            accessibilityId: action.accesibilityId
        )
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        self.scheme = ActionItemBarDefaultViewScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }

    private func addSubviews() {
        [backgroundControlView].addToSuperview(self)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundControlView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundControlView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    private func updateScheme() {
        configure(for: state)
        updateColors()
    }

    private func updateColors() {
        backgroundControlView.scheme = scheme.controlScheme
    }

    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
    }

    private func configureUI() {
        apply(theme: defaultTheme)

        isUserInteractionEnabled = true

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func tap() {
        customAction()
    }

}

