//
//  ToastView.swift
//  AdmiralSwiftUI
//
//  Created on 22.12.2021.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/// Toast view type.
public enum ToastViewType: String {
    /// The default state of the toast.
    case `default`
    /// The success state of the toast.
    case success
    /// The additional state of the toast.
    case additional
    /// The attention state of the toast.
    case attention
    /// The error state of the toast is useful to show the number of errors.
    case error
    
}

/// Toast image type.
public enum ToastImageType: String {
    /// The success state of the image toast.
    case success
    /// The info state of the image toast.
    case info
    /// The attention state of the image toast.
    case attention
    /// The error state of the image toast.
    case error
}

/**
 ToastView - An input field with an informer. It is necessary if additional information may be required to fill in the field correctly.

 You can create a ToastView with the zero frame rectangle by specifying the following parameters in init:

 - title: Title of the toast.
 - linkText: Title of link button.
 - linkAction: Callback of the link button. If callback equal nil link button is hidden.
 - image: Image of the toast. If image equal nil image is hidden.
 - imageType: Type image.
 - imageColorType: Type color image.
 - closeAction: Callback of the close button. If callback equal nil close button is hidden.
 - type: Type color background toast.

 ## Example to create ToastView
 # Code
 ```
 let toastView = ToastView()
 toastView.title = "Text"
 toastView.linkText = "LinkText"
 toastView.type = .default
 toastView.imageType = .success
 toastView.linkAction = {}
 toastView.closeAction ={}
```
 */
open class ToastView: UIView, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// Title of the toast.
    open var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// Title of link button.
    open var  linkText: String? {
        didSet {
            setCenterView()
        }
    }
    
    /// Type color background toast.
    open var type: ToastViewType = .default {
        didSet {
            configure()
        }
    }
    
    /// Timer duration.
    open var timerDuration: Int? {
        didSet {
            configureLeadingView()
        }
    }
    
    /// Toast image type.
    open var imageType: ToastImageType? {
        didSet {
            configureLeadingView()
        }
    }
    
    /// Toast image color type.
    open var imageColorType: ToastImageType? {
        didSet {
            configure()
        }
    }
    
    /// Image of the toast.
    open var image: UIImage? {
        didSet {
            configureLeadingView()
        }
    }
    
    /// Callback of the link button. If callback equal nil link button is hidden.
    open var linkAction: (() -> ())?

    /// Callback of the close button. If callback equal nil close button is hidden.
    open var closeAction: (() -> ())? {
        didSet {
            configureCloseView()
        }
    }
    
    /// Title in close button.
    open var closeTitle: String? {
        didSet {
            configureCloseView()
        }
    }

    /// Close image.
    open var closeImage: UIImage? {
        didSet {
            configureCloseView()
        }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var cardStatusStyle: CardStatusStyle = .noStatus {
        didSet { configure() }
    }
    
    // MARK: - Internal Properties
    
    var scheme = ToastViewScheme() {
        didSet { configure() }
    }
    
    // MARK: - Private Properties
    
    private lazy var trailingLeadingViewContraint: NSLayoutConstraint = {
        return leadingView.trailingAnchor.constraint(equalTo: centerView.leadingAnchor)
    }()
    
    private lazy var leadingCenterViewContraint: NSLayoutConstraint = {
        return centerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    }()
    
    private lazy var trailingCenterViewContraint: NSLayoutConstraint = {
        return centerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    }()
    
    private lazy var leadingTrailingViewContraint: NSLayoutConstraint = {
        return trailingView.leadingAnchor.constraint(equalTo: centerView.trailingAnchor)
    }()
    
    private lazy var titleLabelBottomContraint: NSLayoutConstraint = {
        return centerView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
    }()
    
    private lazy var linkControlTopConstraint: NSLayoutConstraint = {
        return linkControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.module)
    }()
    
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
    
    // MARK: - Private Propeties
    
    private let leadingView = UIView()
    private let centerView = UIView()
    private let trailingView = UIView()
    
    private let iconImageView = UIImageView()
    private let countDownTimer = CountDownTimerView()
   
    private let titleLabel = UILabel()
    private let linkControl = PrimaryLinkControl()
    
    private let closeButton = UIButton()
    
    // MARK: - AppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = ToastViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        titleLabel.font = scheme.titleTextFont.uiFont
        titleLabel.textColor = scheme.titleTextColor.uiColor
        
        backgroundColor = scheme.backgroundColor.parameter(type: type)?.uiColor
        
        if let type = imageColorType ?? imageType {
            iconImageView.tintColor = scheme.imageTintColor.parameter(type: type)?.uiColor
        }
        
        closeButton.setTitleColor(scheme.closeTitleColor.uiColor, for: .normal)
        closeButton.titleLabel?.font = scheme.closeTitleFont.uiFont
        closeButton.tintColor = scheme.closeTintColor.uiColor
        
        countDownTimer.scheme = scheme.countDownTimerViewScheme
        linkControl.scheme = scheme.primaryLinkScheme
    }
    
    private func commonInit() {
        apply(theme: defaultTheme)
        autoManage()
        
        setupLabels()
        addSubviews()
        setupViews()
        
        setUpLinkControl()
        configureConstraints()
        configureLeadingView()
        setCenterView()
        configureCloseView()
    }
    
    private func addSubviews() {
        [leadingView, centerView, trailingView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
        
        [titleLabel, linkControl].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            centerView.addSubview($0)
        })
        
        [iconImageView, countDownTimer].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            leadingView.addSubview($0)
        })
        
        [closeButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            trailingView.addSubview($0)
        })
    }
    
    private func setupViews() {
        layer.cornerRadius = LayoutGrid.module
        layer.masksToBounds = true
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
    }
    
    private func setCenterView() {
        let isHiddenLinkControl = linkText?.nilIfEmpty == nil
        titleLabelBottomContraint.isActive = isHiddenLinkControl
        linkControlTopConstraint.isActive = !isHiddenLinkControl
        linkControl.isHidden = isHiddenLinkControl
        
        setUpLinkControl()
    }
    
    private func setUpLinkControl() {
        linkControl.title = linkText
        linkControl.fontStyle = .body
        linkControl.style = .none
        linkControl.addTarget(self, action: #selector(tapLink), for: .touchUpInside)
    }
    
    @objc private func tapLink() {
        linkAction?()
    }
    
    private func configureLeadingView() {
        
        if let timerDuration = timerDuration {
            countDownTimer.startTo(timerDuration)
            hideLeadingView(isHidden: false)
        } else if let image = image {
            iconImageView.image = image
            hideLeadingView(isHidden: false)
        } else if let imageType = imageType {
            switch imageType {
            case .attention:
                self.iconImageView.image = Asset.Service.Solid.errorTriangleSolid.image
            case .error:
                self.iconImageView.image = Asset.Service.Solid.errorSolid.image
            case .info:
                self.iconImageView.image = Asset.Service.Solid.infoSolid.image
            case .success:
                self.iconImageView.image = Asset.Service.Solid.checkSolid.image
            }
            hideLeadingView(isHidden: false)
        } else {
            iconImageView.image = nil
            hideLeadingView(isHidden: true)
        }
        
        configure()
    }
    
    private func hideLeadingView(isHidden: Bool) {
        iconImageView.isHidden = isHidden ? true : (timerDuration != nil)
        countDownTimer.isHidden = isHidden ? true : (timerDuration == nil)
        trailingLeadingViewContraint.isActive = !isHidden
        leadingCenterViewContraint.isActive = isHidden
        
        leadingView.isHidden = isHidden
    }
    
    private func configureCloseView() {
        if closeAction != nil {
            configureButton()
            hideTrailingView(isHidden: false)
        } else {
            hideTrailingView(isHidden: true)
        }
    }
    
    private func configureButton() {
        if let closeTitle = closeTitle {
            closeButton.setTitle(closeTitle, for: .normal)
            closeButton.setImage(nil, for: .normal)
        } else {
            closeButton.setTitle(nil, for: .normal)
            closeButton.setImage(closeImage ?? Asset.Service.Outline.closeOutline.image, for: .normal)
        }
        
        closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        configure()
    }
    
    @objc private func tapCloseButton() {
        closeAction?()
    }
    
    private func hideTrailingView(isHidden: Bool) {
        leadingTrailingViewContraint.isActive = !isHidden
        trailingCenterViewContraint.isActive = isHidden
        
        trailingView.isHidden = isHidden
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            leadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leadingView.topAnchor.constraint(equalTo: topAnchor),
            leadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingLeadingViewContraint,
            leadingView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 10),
            
            iconImageView.leadingAnchor.constraint(equalTo: leadingView.leadingAnchor, constant: LayoutGrid.doubleModule),
            iconImageView.topAnchor.constraint(equalTo: leadingView.topAnchor, constant: LayoutGrid.doubleModule),
            iconImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            iconImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            
            countDownTimer.leadingAnchor.constraint(equalTo: leadingView.leadingAnchor, constant: LayoutGrid.module),
            countDownTimer.topAnchor.constraint(equalTo: leadingView.topAnchor, constant: LayoutGrid.module),
            countDownTimer.widthAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            countDownTimer.heightAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            
            leadingCenterViewContraint,
            centerView.topAnchor.constraint(equalTo: topAnchor),
            centerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingCenterViewContraint,
            
            titleLabel.topAnchor.constraint(equalTo: centerView.topAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: LayoutGrid.doubleModule),
            centerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabelBottomContraint,
            
            linkControlTopConstraint,
            linkControl.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: LayoutGrid.halfModule),
            centerView.trailingAnchor.constraint(greaterThanOrEqualTo: linkControl.trailingAnchor, constant: LayoutGrid.halfModule),
            centerView.bottomAnchor.constraint(equalTo: linkControl.bottomAnchor, constant: LayoutGrid.halfModule * 3),
            
            leadingTrailingViewContraint,
            trailingView.topAnchor.constraint(equalTo: topAnchor),
            trailingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            closeButton.leadingAnchor.constraint(greaterThanOrEqualTo: trailingView.leadingAnchor, constant: LayoutGrid.doubleModule),
            closeButton.topAnchor.constraint(equalTo: leadingView.topAnchor, constant: LayoutGrid.doubleModule),
            trailingView.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            trailingView.bottomAnchor.constraint(greaterThanOrEqualTo: closeButton.bottomAnchor, constant: LayoutGrid.doubleModule),
            closeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.tripleModule),
            closeButton.heightAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.tripleModule)
        ])
    }
}
