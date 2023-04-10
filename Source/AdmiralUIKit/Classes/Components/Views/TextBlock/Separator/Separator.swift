//
//  Separator.swift
//  AdmiralUIKit
//
//  Created on 12.07.2022.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 SeparatorStyle - Public enum for Separator AdmiralSwiftUI library
 
 HeaderStyle can be one of the following values:
 - long
 - short
 - empty
 */

public enum SeparatorStyle {
    case long
    case short
    case empty
    
    var padding: CGFloat {
        switch self {
        case .long:
            return .zero
        case .short, .empty:
            return LayoutGrid.doubleModule
        }
    }
}

/**
 Separator - separator element with height equal 16 points, exist in three different variants.
 - long - separator whole width
 - short - separator width padding 8 points
 - empty - empty line width height
 
 You can create a Separator by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 - separatorStyle: SeparatorStyle - style of separator
 
 ## Example to create Separator:
    Separator(separatorStyle: .short)
*/
public class Separator: UIView, AnyAppThemable {

    /// Separator style.
    public var separatorStyle: SeparatorStyle = .short {
        didSet { updateSeparatorStyle() }
    }

    /// Color scheme.
    public var scheme = SeparatorScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let separatorView = UIView()
    private lazy var leadingSeparatorConstraint: NSLayoutConstraint = {
        return separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: separatorStyle.padding)
    }()
    private lazy var trallinSeparatorConstraint: NSLayoutConstraint = {
        return trailingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: separatorStyle.padding)
    }()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(separatorStyle: SeparatorStyle = .short) {
        super.init(frame: .zero)
        self.separatorStyle = separatorStyle
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = SeparatorScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [separatorView].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingSeparatorConstraint,
            trallinSeparatorConstraint
        ])
    }
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        separatorView.backgroundColor = separatorStyle == .empty ? .clear : scheme.separatorColor.uiColor
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        updateSeparatorStyle()
    }
    
    private func updateSeparatorStyle() {
        configure()
        leadingSeparatorConstraint.constant = separatorStyle.padding
        trallinSeparatorConstraint.constant = separatorStyle.padding
    }
}
