//
//  GhostButton.swift
//  AdmiralUI
//
//  Created on 14.10.2020.
//

import UIKit
import AdmiralTheme
/**
 Transparent button. It is used in cases where the main button is not enough, often paired with it when you need to designate several actions, one of which is the main one.

 You can create a GhostButton with the zero frame rectangle by specifying the following parameters in init:

 - isLoading: Bool - Loading flag. Activates an  ActivityIndicator when flag sets to true and dissapier when flag sets to false.

 ## Example to create GhostButton
 # Code
 ```
 let ghostButton = GhostButton()
 uploadDocumentView.isLoading = false
 uploadDocumentView.trackProgressStyle = .default
```
 */
/// The view that presents backgound image with loader for uploading and downloading process.
open class GhostButton: CustomButton, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    open var scheme = GhostButtonCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Public Properties
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    /// Loading indicator. Activates when flag sets to true and dissapier when flag sets to false.
    public var isLoading: Bool = false {
        didSet {
            configureActivityIndicator(isLoading: isLoading)
            updateSchemeColors()
        }
    }

    // MARK: - Private properties

    private var activityIndicator = ActivityIndicator()

    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: LayoutGrid.doubleModule * 3)
    }
    
    // MARK: - AnyAppThemable
    
    open func apply(theme: AppTheme) {
        scheme = GhostButtonCustomScheme(theme: theme)
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
        setupConstaints()
        setupUI()
    }

    private func addSubviews() {
        [activityIndicator].addToSuperview(self)
    }

    private func setupConstaints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupUI() {
        activityIndicator.style = .default
        activityIndicator.size = .medium
        activityIndicator.isHidden = true
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.isExclusiveTouch = false
    }

    private func configureActivityIndicator(isLoading: Bool = false) {
        if isLoading {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }

    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }

    private func updateSchemeColors() {
        setTitleColor(isLoading ? .clear : scheme.normalTextColor.uiColor, for: .normal)
        setTitleColor(isLoading ? .clear : scheme.highlightedTextColor.uiColor, for: .highlighted)
        setTitleColor(isLoading ? .clear : scheme.disabledTextColor.uiColor, for: .disabled)
        
        setTintColor(scheme.normalTextColor.uiColor, for: .normal)
        setTintColor(scheme.highlightedTextColor.uiColor, for: .highlighted)
        setTintColor(scheme.disabledTextColor.uiColor, for: .disabled)
        
        imageView?.tintColor = scheme.normalTextColor.uiColor

        activityIndicator.scheme = scheme.activityIndicatorScheme
    }
    
    private func updateSchemeFonts() {
        titleLabel?.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

}
