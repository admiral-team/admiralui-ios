//
//  Badge.swift
//  AdmiralUI
//
//  Created on 16.10.2020.
//

import UIKit
import AdmiralTheme

/// The style of badge.
public enum BadgeStyle: Int {
    /// The natural state of the badge
    case natural
    /// The default state of the badge
    case `default`
    /// The additional state of the badge
    case additional
    /// The success state of the badge
    case success
    /// The error state of the badge is useful to show the number of errors
    case error
    /// The attention state of the badge is useful to show the number of attentions
    case attention
}

/// The state of badge.
enum BadgeState: Int {
    /// The normal state of the badge
    case normal
    /// The disabled state of the badge
    case disabled
}

/// Badge is a component that usually complements other components and shows quantitative scores.
/// For example, a Tabs component can show the number of items in a bookmark. Or show the number of notifications in the notification panel.
open class Badge: UIView, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        enum Insets {
            static let `default` = CGSize(width: LayoutGrid.module, height: 0)
            static let point = CGSize(width: LayoutGrid.halfModule * 1.5, height: LayoutGrid.halfModule * 1.5)
        }
        
        enum Size {
            static let `default` = CGSize(width:  LayoutGrid.halfModule * 5, height:  LayoutGrid.halfModule * 5)
            static let point = CGSize(width: LayoutGrid.halfModule * 3, height: LayoutGrid.halfModule * 3)
        }
    }

    // MARK: - Public Properties
    
    /// The font used to display the text.
    var font: UIFont? {
        get { return badgeLabel.font }
        set { badgeLabel.font = newValue }
    }
    
    /// The text that the badge is displaying.
    open var text: String? {
        get { return badgeLabel.text }
        set { updateText(newValue) }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var isEnabled: Bool = true {
        didSet { updateScheme()  }
    }
    
    /// Badge style to configure the badge with library styles or custom style.
    open var style: BadgeStyle = .default {
        didSet { updateScheme()  }
    }
    
    /// Badge insets that describe the margin between text and the edge of the badge.
    open var insets: CGSize {
        get { return badgeLabel.insets }
        set { badgeLabel.insets = newValue }
    }
    
    /// Minimum badge size.
    open var minSize: CGSize? {
        get { return badgeLabel.minSize }
        set { badgeLabel.minSize = newValue }
    }
    
    // MARK: - Internal Properties
    
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    var scheme = BadgeScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let badgeLabel = BadgeLabel()
    
    private var state: BadgeState {
        return isEnabled ? .normal : .disabled
    }
        
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience public init() {
        self.init(frame: CGRect())
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = min(frame.width, frame.height) / 2
    }
    
    // MARK: - AppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = BadgeScheme(theme: theme)
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateText(_ text: String?) {
        badgeLabel.text = text
        insets = text != nil ? Constants.Insets.default : Constants.Insets.point
        minSize = text != nil ? Constants.Size.default : Constants.Size.point
    }
        
    private func updateSchemeColors() {
        badgeLabel.textColor = scheme.textColor.parameter(for: state, style: style)?.uiColor
        borderColor = scheme.borderColor.parameter(for: state, style: style)?.uiColor
        badgeLabel.backgroundColor = scheme.backgroundColor.parameter(for: state, style: style)?.uiColor
    }
    
    private func commonInit() {
        [badgeLabel].addToSuperview(self)
        badgeLabel.fillView(view: self).activate()
        configureUI()
    }
    
    private func configureUI() {
        clipsToBounds = true
        badgeLabel.minSize = Constants.Size.default
        insets = Constants.Insets.default
        
        borderWidth = LayoutGrid.halfModule / 2
        
        apply(theme: defaultTheme)
    }
    
    private func state(isEnabled: Bool) -> BadgeState {
        return isEnabled ? .normal : .disabled
    }
    
    private func updateSchemeFonts() {
        badgeLabel.setDynamicFont(
            font: scheme.font.uiFont,
            textStyle: scheme.font.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
        
}

private final class BadgeLabel: UILabel {
    
    var insets: CGSize = .zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    var minSize: CGSize? {
        didSet { invalidateIntrinsicContentSize() }
    }

    // MARK: - Private Metohds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        clipsToBounds = false
        textAlignment = .center
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)

        guard let _ = text else {
            return CGRect(
                x: 0,
                y: 0,
                width: LayoutGrid.module + 2,
                height: LayoutGrid.module + 2)
        }

        guard let minSize = self.minSize else {
            return CGRect(
                x: 0,
                y: 0,
                width: rect.width + 2 * insets.width,
                height: rect.height + 2 * insets.height)
        }

        return CGRect(
            x: 0,
            y: 0,
            width: rect.width + 2 * insets.width,
            height: minSize.height
        )

    }

}
