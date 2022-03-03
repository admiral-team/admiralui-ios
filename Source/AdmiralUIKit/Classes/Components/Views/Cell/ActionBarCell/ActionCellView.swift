//
//  ActionCellView.swift
//  AdmiralUI
//
//  Created on 30.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object for present action bar.
public class ActionCellView<T>: UIView, AnyAppThemable, UIGestureRecognizerDelegate where T: ListViewCell {
    
    // MARK: - Public Properties
    
    public var isEnabled: Bool {
        get { !state.contains(.disabled) }
        set {
            if newValue {
                state.remove(.disabled)
            } else {
                state.insert(.disabled)
            }
            cellView.isEnabled = newValue
            actionView.isEnabled = newValue
        }
    }
    
    /// Cell view.
    public let cellView: T
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    var state: UIControl.State = .normal {
        didSet { configure(for: state) }
    }
    
    var scheme = ActionCellViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties

    private var isOpen: Bool = false
    private let actionView: ActionBarView
    private lazy var leadingConstraint: NSLayoutConstraint = {
        return leadingAnchor.constraint(equalTo: cellView.leadingAnchor)
    }()

    private let style: ActionBarViewStyle
    
    // MARK: - Initializer
    
    public init(cellView: T, style: ActionBarViewStyle = .default) {
        self.cellView = cellView
        self.style = style
        self.actionView = ActionBarView(style: style)
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = ActionCellViewScheme(theme: theme)
        cellView.apply(theme: theme)
        actionView.apply(theme: theme)
    }
    
    // MARK: - Public Methods
    
    /// Attaches an action object to the action bar.
    /// - Parameter action: An action that can be taken when the user taps a button in an action bar.
    public func appendAction(_ action: ActionItemBarAction) {
        actionView.appendAction(action)
    }
    
    /// Insert action object to action bar.
    /// - Parameters:
    ///   - action: An action that can be taken when the user taps a button in an action bar.
    ///   - index: insert action index.
    public func insertAction(_ action: ActionItemBarAction, index: Int) {
        actionView.insertAction(action, index: index)
    }
    
    /// Remove action object from action bar.
    /// - Parameter index: remove action index.
    public func removeAction(index: Int) {
        actionView.removeAction(from: index)
    }
    
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return isOpen
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [actionView, cellView].addToSuperview(self)
    }
    
    private func configureLayout() {
        let height = heightAnchor.constraint(equalTo: cellView.heightAnchor)
        let heightConstant = heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 18)

        NSLayoutConstraint.activate([
            leadingConstraint,
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor),

            widthAnchor.constraint(equalTo: cellView.widthAnchor),
            actionView.topAnchor.constraint(equalTo: topAnchor),
            actionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        let const = style == .default ? [height] : [heightConstant]
        NSLayoutConstraint.activate(const)
    }
    
    private func updateScheme() {
        configure(for: state)
    }
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        actionView.backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        cellView.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        cellView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        cellView.addGestureRecognizer(swipeRight)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        tapRecognizer.delegate = self
        cellView.addGestureRecognizer(tapRecognizer)
        
        let tapActionViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        tapActionViewRecognizer.delegate = self
        actionView.addGestureRecognizer(tapActionViewRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gestureRecognizer:)))
        cellView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func tapCell() {
        hide()
    }
    
    @objc private func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            show()
        }
    }
    
    @objc private func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        guard state != .disabled else { return }
        
        switch gestureRecognizer.state {
        case .began, .changed:
            let translation = gestureRecognizer.translation(in: cellView)
            if isOpen {
                leadingConstraint.constant = max(actionView.frame.width - translation.x, 0)
            } else {
                leadingConstraint.constant = max(-translation.x, 0)
            }
        case .ended:
            if isOpen {
                if leadingConstraint.constant > actionView.frame.width - LayoutGrid.quadrupleModule {
                    show()
                } else {
                    hide()
                }
            } else {
                if leadingConstraint.constant > LayoutGrid.quadrupleModule {
                    show()
                } else {
                    hide()
                }
            }
        default:
            break
        }
    }
    
    private func show() {
        guard state != .disabled else { return }
        
        leadingConstraint.constant = actionView.frame.width
        isOpen = true
        UIView.animate(
            withDuration: Durations.Default.half,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func hide() {
        leadingConstraint.constant = 0.0
        isOpen = false
        UIView.animate(
            withDuration: Durations.Default.half,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.layoutIfNeeded()
            }, completion: nil)
    }
    
}
