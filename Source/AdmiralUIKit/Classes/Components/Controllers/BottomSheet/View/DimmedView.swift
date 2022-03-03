//
//  DimmedView.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit
import AdmiralTheme

/// A dimmed view for use as an overlay over content you want dimmed.
class DimmedView: UIView, AnyAppThemable {

    enum DimState {
        case max
        case off
        case percent(CGFloat)
    }

    // MARK: - Internal Properties

    var dimState: DimState = .off {
        didSet {
            switch dimState {
            case .max:
                alpha = 1.0
            case .off:
                alpha = 0.0
            case .percent(let percentage):
                alpha = max(0.0, min(1.0, percentage))
            }
        }
    }

    var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)?

    var scheme = DimmedViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private lazy var tapGesture: UIGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(didTapView))
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        apply(theme: defaultTheme)
        
        alpha = 0.0
        addGestureRecognizer(tapGesture)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = DimmedViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
    @objc private func didTapView() {
        didTap?(tapGesture)
    }

}
