//
//  LinkView.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// Link view header delegate.
public protocol LinkViewHeaderDelegate: AnyObject {
    
    /**
     Tells the delegate that the button selected.
     
     - Parameter button: - current button.
     */
    func tapLinkViewHeaderButton(_ button: UIButton)
}

/**
 LinkViewHeader - A header with link button.

 You can create a LinkView by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - title: String - The text that the button displays
 
 ## Example to create LinkViewHeader:
 # Code
 ```
 LinkViewHeader(
    title: "Button")
 ```
*/

/// The state of LinkViewHeader.
enum LinkViewHeaderState: Int {
    /// The normal state of the LinkViewHeader
    case normal
    /// The disabled state of the LinkViewHeader
    case disabled
}

/// A header with header title.
public class LinkViewHeader: UIView, AnyAppThemable {
    
    weak var delegate: LinkViewHeaderDelegate?

    // MARK: - Public Properties

    /// A Boolean value indicating whether the control is in the enabled state.
    open var isEnabled: Bool = true {
        didSet { updateScheme()  }
    }
    
    /// The text that the label displays.
    public var title: String? {
        get { return ghostButton.titleLabel?.text }
        set { ghostButton.setTitle(newValue, for: .normal) }
    }

    // MARK: - Internal Properties
    
    var scheme = LinkViewHeaderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let ghostButton = GhostButton()
    public let headerStyle: HeaderStyle = .link
    
    private var state: BadgeState {
        return isEnabled ? .normal : .disabled
    }
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        return heightAnchor.constraint(greaterThanOrEqualToConstant: headerStyle.height)
    }()
    private lazy var textLabelTopConstraint: NSLayoutConstraint = {
        return ghostButton.topAnchor.constraint(equalTo: topAnchor, constant: headerStyle.edgeInsets.top)
    }()
    private lazy var textLabelBottomConstraint: NSLayoutConstraint = {
        return bottomAnchor.constraint(equalTo: ghostButton.bottomAnchor, constant: headerStyle.edgeInsets.bottom)
    }()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(title: String?) {
        super.init(frame: .zero)
        self.title = title
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = LinkViewHeaderScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureControl()
        configureLayout()
    }
    
    private func addSubviews() {
        [ghostButton].addToSuperview(self)
    }
    
    private func configureControl() {
        ghostButton.addTarget(self, action: #selector(tapLinkControl(_:)), for: .touchUpInside)
    }
    
    @objc private func tapLinkControl(_ button: UIButton) {
        delegate?.tapLinkViewHeaderButton(button)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            ghostButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            textLabelTopConstraint,
            textLabelBottomConstraint,
            trailingAnchor.constraint(greaterThanOrEqualTo: ghostButton.trailingAnchor, constant: headerStyle.edgeInsets.right),
            
            heightConstraint
        ])
    }
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        ghostButton.scheme = scheme.ghostScheme
        ghostButton.isEnabled = isEnabled
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        updateHeaderStyle()
    }
    
    private func updateHeaderStyle() {
        configure()
        
        heightConstraint.constant = headerStyle.height
        textLabelTopConstraint.constant = headerStyle.edgeInsets.top
        textLabelBottomConstraint.constant = headerStyle.edgeInsets.bottom
    }
    
}
