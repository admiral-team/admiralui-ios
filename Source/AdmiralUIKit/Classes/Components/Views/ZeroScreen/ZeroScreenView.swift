//
//  ZeroScreenView.swift
//  AdmiralUIResources
//
//  Created on 16.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// The protocol that describes communication with ZeroScreenView.
public protocol ZeroScreenViewDelegate: AnyObject {
    func didTapButton(_ zeroScreenView: ZeroScreenView)
}

/**
 ZeroScreenView - the component is used to attract the user's attention as a message. A view with title, subtitle and image.
 
 You can create a ZeroScreenView with the zero frame rectangle by specifying the following parameters in init:
 
 - delegate: ZeroScreenViewDelegate? - The delegate of ZeroScreenView (tap button).
 
 - image: Image - The image displayed in the image view.
 - title: String - The text that the title label displays.
 - subTitle: String - The text that the subtitle label displays.
 - buttonTitle: String - The text that the button displays.
 
 ## Example to create ZeroScreenView
 # Code
 ```
 ZeroScreenView(
                image: Asset.Onboarding.one.image,
                title: Constants.title,
                subTitle: Constants.subTitle,
                buttonTitle: Constants.buttonTitle)

```
 */
open class ZeroScreenView: UIView, AnyAppThemable {
    
    // MARK: - Constants
    
    private enum Constants {
        static let imageSize = CGFloat(54.0)
    }
    
    // MARK: - Public Properties

    /// Color scheme.
    public var scheme = ZeroScreenScheme() {
        didSet { updateScheme() }
    }
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    public var primaryButtonAccesibilityId: String? {
        didSet {
            primaryButton.accessibilityIdentifier = primaryButtonAccesibilityId
        }
    }
    
    /// The delegate of ZeroScreenView.
    weak public var delegate: ZeroScreenViewDelegate? = nil
    
    // MARK: - Private properties
    
    private let imageView = UIImageView()
    private let titleView = UILabel()
    private let subTitleView = UILabel()
    private let primaryButton = PrimaryButton()
    
    /// The image displayed in the imageView
    private var image: UIImage?
    
    /// The text that the title label displays.
    private var title: String?
    
    /// The text that the subtitle label displays.
    private var subTitle: String?
    
    /// The text that the button displays.
    private var buttonTitle: String?

    // MARK: - Initializer

    public init(
        image: UIImage? = nil,
        title: String? = nil,
        subTitle: String? = nil,
        buttonTitle: String? = nil
    ) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.buttonTitle = buttonTitle
        super.init(frame: CGRect())
        commonInit()
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
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        self.scheme = ZeroScreenScheme(theme: theme)
    }
    
    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
        setupUI()
    }
    
    private func addSubviews() {
        var subViews: [UIView] = []
        
        if image != nil {
            subViews.append(imageView)
        }
        if title != nil {
            subViews.append(titleView)
        }
        if subTitle != nil {
            subViews.append(subTitleView)
        }
        if buttonTitle != nil {
            subViews.append(primaryButton)
        }
        
        subViews.addToSuperview(self)
    }
    
    private func setupConstraints() {
        var viewsConstraints: [NSLayoutConstraint] = []
        
        if image != nil {
            viewsConstraints.append(contentsOf: [
                imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
                imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
        if title != nil {
            viewsConstraints.append(contentsOf: [
                titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
                trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: LayoutGrid.doubleModule),
                titleView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        if subTitle != nil {
            viewsConstraints.append(contentsOf: [
                subTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
                trailingAnchor.constraint(equalTo: subTitleView.trailingAnchor, constant: LayoutGrid.doubleModule)
            ])
        }
        if buttonTitle != nil {
            viewsConstraints.append(contentsOf: [
                primaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
                trailingAnchor.constraint(equalTo: primaryButton.trailingAnchor, constant: LayoutGrid.doubleModule),
                bottomAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: LayoutGrid.halfModule * 9)
            ])
        }
        
        if image != nil {
            let imageConstraint: NSLayoutConstraint
            
            if title != nil {
                imageConstraint =  titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: LayoutGrid.module * 6)
            } else if subTitle != nil {
                imageConstraint =  subTitleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: LayoutGrid.module * 6)
            } else {
                imageConstraint = imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            }
            viewsConstraints.append(imageConstraint)
        }
        
        if subTitle != nil {
            let subtitleConstraint: NSLayoutConstraint
            if title != nil {
                subtitleConstraint = subTitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: LayoutGrid.halfModule * 6)
            } else {
                subtitleConstraint = subTitleView.centerYAnchor.constraint(equalTo: centerYAnchor)
            }
            viewsConstraints.append(subtitleConstraint)
        }
        
        NSLayoutConstraint.activate(viewsConstraints)

    }

    private func setupUI() {
        imageView.image = image
        
        titleView.text = title
        titleView.numberOfLines = .zero
        titleView.textAlignment = .center
        
        subTitleView.text = subTitle
        subTitleView.numberOfLines = .zero
        subTitleView.textAlignment = .center
        
        primaryButton.setTitle(buttonTitle, for: .normal)
        primaryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped(sender: UIButton) {
        delegate?.didTapButton(self)
    }

    private func updateScheme() {
        updateFonts()
        updateColors()
    }

    private func updateFonts() {
        titleView.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        
        subTitleView.setDynamicFont(
            font: scheme.subtitleFont.uiFont,
            textStyle: scheme.subtitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

    private func updateColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleView.textColor = scheme.titleColor.uiColor
        subTitleView.textColor = scheme.subtitleColor.uiColor
        primaryButton.scheme = scheme.primaryButtonScheme
    }
    
}

