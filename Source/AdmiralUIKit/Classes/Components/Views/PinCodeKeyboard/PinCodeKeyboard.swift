//
//  PinCodeKeyboard.swift
//  AdmiralUIResources
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// Delegate protocol to handle PinKeyboardActions
public protocol PinCodeKeyboardDelegate: AnyObject {
    func pincodeViewDidTapItem(_ view: PinCodeKeyboard, text: String)
    func pincodeViewDidTapLeftAccessoryItem(_ view: PinCodeKeyboard)
    func pincodeViewDidTapRightAccessoryItem(_ view: PinCodeKeyboard)
}

/// A horizontal control made of multiple segments with icons
public class PinCodeKeyboard: UIView, AnyAppThemable {

    // MARK: - Public Properties

    /// An image for right button
    public var rightButtonImage: UIImage? = Asset.Security.Outline.faceIDOutline.image {
        didSet { setRightButtonImage(image: rightButtonImage) }
    }

    /// Title for left button
    public var leftButtontTitle: String? = "Не могу войти" {
        didSet { setLeftButtonTitle(title: leftButtontTitle) }
    }

    /// Title for right button
    public var rightButtonTitle: String? {
        didSet { setRightButtonTitle(title: rightButtonTitle) }
    }

    /// The accessibility identifier
    public var textViewAccesibilityId: String? {
        get {
            return textView.accessibilityId
        } set {
            textView.accessibilityId = newValue
        }
    }

    /// PinCodeKeyboard Delegate
    public weak var delegate: PinCodeKeyboardDelegate?

    // MARK: - Internal Properties

    public var scheme = PinCodeKeyboardCustomScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutGrid.doubleModule

        return stackView
    }()

    private let textView = PinCodeTextView()

    private var selectedIndex: Int = 0
    private var heightStackViewConstraint: NSLayoutConstraint!

    // MARK: - Initializers

    /// Initializes and returns a newly allocated view object.
    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - AnyAppThemable

    public func apply(theme: AppTheme) {
        scheme = PinCodeKeyboardCustomScheme(theme: theme)
        stackView.arrangedSubviews.forEach({
            ($0 as? AppThemeCompatible)?.apply(theme: theme)
        })
    }

    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)

        addSubviews()
        setupConstraints()
        setupNumberPad()
    }

    private func addSubviews() {
        [stackView].addToSuperview(self)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 6),
            stackView.widthAnchor.constraint(equalToConstant: 320.0),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGrid.halfModule * 7)
        ])
    }

    private func updateScheme() {
        backgroundColor = scheme.backgroundColor.uiColor
    }

    @objc private func tapSegment(_ control: UIControl) {
        if (control is PinCodeTextView) {
            delegate?.pincodeViewDidTapLeftAccessoryItem(self)
        }

        switch (control as? PinCodeNumberView)?.viewState {
        case .number(let number):
            delegate?.pincodeViewDidTapItem(self, text: String(number))
        case .rightAction:
            delegate?.pincodeViewDidTapRightAccessoryItem(self)
        default:
            return
        }
    }

    private func setupNumberPad() {
        let items = createHorizontalItems()
        items.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private func createHorizontalItems() -> [UIStackView] {
        var stackViews = [UIStackView]()

        for i in 0...2 {
            var items = [PinCodeNumberView]()
            for j in 1...3 {
                let number = j + i * 3
                items.append(createItem(.init(state: .number(number))))
            }
            stackViews.append(createHorizontalStack(items: items))
        }

        stackViews.append(createButtonsHorizontalStack())
        return stackViews
    }

    private func createButtonsHorizontalStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutGrid.doubleModule

        textView.title = leftButtontTitle
        textView.addTarget(self, action: #selector(tapSegment(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(createItem(.init(state: .number(0))))
        stackView.addArrangedSubview(
            createItem(
                .init(
                    state: .rightAction(.init(title: rightButtonTitle, image: rightButtonImage))
                )
            )
        )
        return stackView
    }

    private func createHorizontalStack(items: [PinCodeNumberView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutGrid.doubleModule

        items.forEach { stackView.addArrangedSubview($0) }

        return stackView
    }

    private func createItem(_ model: PinCodeNumber) -> PinCodeNumberView {
        let item = PinCodeNumberView()
        item.viewState = model.state
        item.accessibilityId = model.accesibilityId
        item.addTarget(self, action: #selector(tapSegment(_:)), for: .touchUpInside)
        return item
    }

    private func setLeftButtonTitle(title: String?) {
        stackView.arrangedSubviews.forEach {
            guard let view = ($0 as? PinCodeTextView) else { return }

            view.title = leftButtontTitle
        }
    }

    private func setRightButtonTitle(title: String?) {
        stackView.arrangedSubviews.forEach {
            guard
                let view = ($0 as? PinCodeNumberView),
                let state = view.viewState else { return }

            switch state {
            case .rightAction:
                view.title = title
            default:
                return
            }
        }
    }

    private func setRightButtonImage(image: UIImage?) {
        stackView.arrangedSubviews.forEach {
            ($0 as? UIStackView)?.arrangedSubviews.forEach({
                guard
                    let view = ($0 as? PinCodeNumberView),
                    let state = view.viewState else { return }

                switch state {
                case .rightAction:
                    view.image = rightButtonImage
                default:
                    return
                }
            })
        }
    }

}

