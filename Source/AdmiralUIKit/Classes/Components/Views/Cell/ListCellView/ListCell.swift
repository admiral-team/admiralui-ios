//
//  ListCell.swift
//  AdmiralUI
//
//  Created on 20.11.2020.
//

import UIKit
import AdmiralTheme

/// The protocol with properties and methods for list cell.
public protocol ListViewCell: UIView, AppThemeCompatible {
    
    /// A Boolean value indicating whether the view is in the enabled state.
    var isEnabled: Bool { get set }
    
    /// A Boolean value indicating whether the view is in the highlighted state.
    var isHighlighted: Bool { get set }
}

/// A view that displays leading, traling and image views.
public class ListCell<L, C, T>: UIView, AnyAppThemable, ListViewCell where C: CenterListViewComponent,
                                                                           T: TralingListViewComponent,
                                                                           L: LeadingListViewComponent,
                                                                           C: AnyAppThemable,
                                                                           T: AnyAppThemable,
                                                                           L: AnyAppThemable {
    
    /// A Boolean value indicating whether the view is in the enabled state.
    public var isEnabled: Bool {
        get { !state.contains(.disabled) }
        set {
            if newValue {
                state.remove(.disabled)
            } else {
                isHighlighted = false
                state.insert(.disabled)
            }
            centerView?.isEnabled = newValue
            tralingView?.isEnabled = newValue
            leadingView?.isEnabled = newValue
        }
    }
    
    /// A Boolean value indicating whether the view is in the highlighted state.
    public var isHighlighted: Bool {
        get { state.contains(.highlighted) }
        set {
            guard isEnabled else { return }
            
            if newValue {
                state.insert(.highlighted)
            } else {
                state.remove(.highlighted)
            }
            centerView?.isHighlighted = newValue
            tralingView?.isHighlighted = newValue
            leadingView?.isHighlighted = newValue
        }
    }
    
    /// Center view.
    public let centerView: C?
    
    /// Traling view.
    public let tralingView: T?
    
    /// Leading view.
    public let leadingView: L?
    
    /// Offset for leading view.
    public var leaingOffset: CGFloat = 0 {
        didSet { updateLeadingConstraints() }
    }
    
    /// Offset for center view.
    public var centerOffset: CGFloat = 0 {
        didSet { updateCenterConstraints() }
    }
    
    /// Offset for trailing view.
    public var trailingOffset: CGFloat = 0 {
        didSet { updateTrailingConstraints() }
    }

    /// Color scheme.
    public var scheme = ListCellScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    /// The state of the view. Default is normal.
    private var state: UIControl.State = .normal {
        didSet { configure() }
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - leadingView: leading view.
    ///   - centerView: center view.
    ///   - tralingView: traling view.
    public init(leadingView: L?, centerView: C?, tralingView: T?) {
        self.centerView = centerView
        self.tralingView = tralingView
        self.leadingView = leadingView
        super.init(frame: .zero)
        
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - centerView: center view.
    ///   - tralingView: traling view.
    public init(centerView: C?, tralingView: T?) {
        self.centerView = centerView
        self.tralingView = tralingView
        self.leadingView = nil
        super.init(frame: .zero)
        
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - leadingView: leading view.
    public init(centerView: C?) {
        self.centerView = centerView
        self.tralingView = nil
        self.leadingView = nil
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    
    private var leadingViewLeadingConstraint: NSLayoutConstraint?
    
    private var centerViewLeadingConstraint: NSLayoutConstraint?
    private var centerViewTrailingConstraint: NSLayoutConstraint?
    
    private var trailingViewTrailingConstraint: NSLayoutConstraint?
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = ListCellScheme(theme: theme)
        leadingView?.apply(theme: theme)
        centerView?.apply(theme: theme)
        tralingView?.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
    }
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        for view in [leadingView, centerView, tralingView] {
            if let view = view {
                view.translatesAutoresizingMaskIntoConstraints = false
                addSubview(view)
            }
        }
    }
    
    private func configureLayout() {
        let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: 68.0)
        heightConstraint.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        
        NSLayoutConstraint.activate([
            heightConstraint
        ])
        
        if let imageView = leadingView {
            let leading = imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
            leadingViewLeadingConstraint = leading
            NSLayoutConstraint.activate([
                leading,
                imageView.topAnchor.constraint(equalTo: topAnchor),
                bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 15)
            ])
        }
        
        if let tralingView = tralingView {
            let trailing = trailingAnchor.constraint(equalTo: tralingView.trailingAnchor)
            trailingViewTrailingConstraint = trailing
            NSLayoutConstraint.activate([
                trailing,
                tralingView.topAnchor.constraint(equalTo: topAnchor),
                bottomAnchor.constraint(equalTo: tralingView.bottomAnchor)
            ])
            if centerView == nil {
                if let imageView = leadingView {
                    NSLayoutConstraint.activate([
                        imageView.trailingAnchor.constraint(equalTo: tralingView.leadingAnchor)
                    ])
                } else {
                    NSLayoutConstraint.activate([
                        leadingAnchor.constraint(equalTo: tralingView.leadingAnchor)
                    ])
                }
            } 
        }
        
        if let centerView = centerView {
            NSLayoutConstraint.activate([
                centerView.topAnchor.constraint(equalTo: topAnchor),
                bottomAnchor.constraint(equalTo: centerView.bottomAnchor)
            ])
            
            if let imageView = leadingView {
                let leading = centerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor)
                centerViewLeadingConstraint = leading
                NSLayoutConstraint.activate([
                    leading
                ])
            } else {
                let leading = centerView.leadingAnchor.constraint(equalTo: leadingAnchor)
                centerViewLeadingConstraint = leading
                NSLayoutConstraint.activate([
                    leading
                ])
            }
            
            if let tralingView = tralingView {
                let trailing = tralingView.leadingAnchor.constraint(equalTo: centerView.trailingAnchor)
                centerViewTrailingConstraint = trailing
                NSLayoutConstraint.activate([
                    trailing
                ])
            } else {
                let trailing = trailingAnchor.constraint(equalTo: centerView.trailingAnchor)
                centerViewTrailingConstraint = trailing
                NSLayoutConstraint.activate([
                    trailing
                ])
            }
        }
    }
    
    private func updateLeadingConstraints() {
        leadingViewLeadingConstraint?.constant = leaingOffset
        
        updateLayout()
    }
    
    private func updateCenterConstraints() {
        centerViewLeadingConstraint?.constant = centerOffset
        centerViewTrailingConstraint?.constant = centerOffset
        
        updateLayout()
    }
    
    private func updateTrailingConstraints() {
        trailingViewTrailingConstraint?.constant = trailingOffset
        
        updateLayout()
    }
    
    private func updateLayout() {
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
    }
    
}
