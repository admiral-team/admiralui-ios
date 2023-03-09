//
//  ActionBarView.swift
//  AdmiralUI
//
//  Created on 02.12.2020.
//

import UIKit
import AdmiralTheme

public enum ActionBarViewStyle {
    case `default`
    case secondary
}

private protocol ActionBarViewStyleProtocol {
    func build(by action: ActionItemBarAction) -> ActionBarViewPresentable
}

class ActionBarView: UIView, ActionBarViewStyleProtocol, AnyAppThemable {
    
    enum Constant {
        static let width: CGFloat = 32.0
        static let buttonInset: CGFloat = LayoutGrid.halfModule * 3
        static let customWidth: CGFloat = 90
    }
    
    // MARK: - Internal Properties
    
    var isEnabled: Bool {
        get { !state.contains(.disabled) }
        set {
            if newValue {
                state.remove(.disabled)
            } else {
                state.insert(.disabled)
            }
        }
    }
    
    /// The state of the view. Default is normal.
    var state: UIControl.State = .normal {
        didSet { configure(for: state) }
    }
    
    var scheme = ActionBarViewScheme() {
        didSet { updateScheme() }
    }
    
    init(style: ActionBarViewStyle = .default) {
        self.style = style
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Computed properties
    
    private var width: CGFloat {
        style == .default ? Constant.width : Constant.customWidth
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = ActionBarViewScheme(theme: theme)
        views.forEach {
            if let view = $0 as? ActionItemBarDefaultView {
                view.apply(theme: theme)
            } else if let view = $0 as? ActionItemBarViewSecondary {
                view.apply(theme: theme)
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let style: ActionBarViewStyle
    private var views: [ActionBarViewPresentable] = []
    
    // MARK: - Internal Methods
    
    func appendAction(_ action: ActionItemBarAction) {
        let actionBarView = configureView(action)
        configureTralingViewConstraint(actionBarView, index: views.count)
        
        views.append(actionBarView)
    }
    
    func insertAction(_ action: ActionItemBarAction, index: Int) {
        guard views.count > index else {
            appendAction(action)
            return
        }
        
        let actionBarView = configureView(action)
        views.insert(actionBarView, at: index)
        
        for index in 0..<views.count {
            configureTralingViewConstraint(views[index], index: index)
        }
    }
    
    func removeAction(from index: Int) {
        views.remove(at: index)
        
        for index in 0..<views.count {
            configureTralingViewConstraint(views[index], index: index)
        }
    }
    
    // MARK: - Private Methods
    
    private func configure(for state: UIControl.State) {
        for view in views {
            view.isEnabled = isEnabled
        }
    }
    
    private func configureTralingViewConstraint(_ view: ActionBarViewPresentable, index: Int) {
        var offsetTraling: CGFloat = .zero
        
        if index == 0 {
            offsetTraling = style == .default ? LayoutGrid.doubleModule : .zero
        } else {
            let defaultTrailing = LayoutGrid.doubleModule + (width * CGFloat(index)) + (Constant.buttonInset * CGFloat(index))
            let customTrailing: CGFloat = width * CGFloat(index)
            offsetTraling = style == .default ? defaultTrailing : customTrailing
        }
        
        if view.tralingConstraint != nil {
            view.tralingConstraint?.constant = offsetTraling
        } else {
            let tralingAnchor = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offsetTraling)
            NSLayoutConstraint.activate([
                tralingAnchor
            ])
            view.tralingConstraint = tralingAnchor
        }
    }
    
    private func configureView(_ action: ActionItemBarAction) -> ActionBarViewPresentable {
        let view = build(by: action)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.widthAnchor.constraint(equalToConstant: width),
            view.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: style == .default ? LayoutGrid.doubleModule : .zero)
        ])
        
        return view
    }
    
    private func updateScheme() {
        backgroundColor = scheme.backgroundColor.uiColor
        views.forEach {
            if let view = $0 as? ActionItemBarDefaultView {
                view.scheme = scheme.actionBarConrolSchemeDefault
            } else if let view = $0 as? ActionItemBarViewSecondary {
                view.scheme = scheme.actionBarControlSchemeSecondary
            }
        }
    }
    
}

// MARK: - Protocol extensions
extension ActionBarViewStyleProtocol {
    
    func build(by action: ActionItemBarAction) -> ActionBarViewPresentable {
        switch action.style {
        case .default:
            return ActionItemBarDefaultView(action: action)
        case .secondary:
            return ActionItemBarViewSecondary(action: action)
        }
    }
    
}
