//
//  SearchBar.swift
//  AdmiralUI
//
//  Created on 21.02.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// A collection of optional methods that you implement to make a search bar control functional.
@objc public protocol SearchBarDelegate: AnyObject {
    /// Asks the delegate if editing should begin in the specified search bar.
    @objc optional func searchBarShouldBeginEditing(_ searchBar: SearchBar) -> Bool
    
    /// Tells the delegate when the user begins editing the search text.
    @objc optional func searchBarTextDidBeginEditing(_ searchBar: SearchBar)
    
    /// Asks the delegate if editing should stop in the specified search bar.
    @objc optional func searchBarShouldEndEditing(_ searchBar: SearchBar) -> Bool
    
    /// Tells the delegate that the user finished editing the search text.
    @objc optional func searchBarTextDidEndEditing(_ searchBar: SearchBar)
    
    /// Tells the delegate that the user changed the search text.
    @objc optional func searchBar(_ searchBar: SearchBar, textDidChange searchText: String)
    
    /// Ask the delegate if text in a specified range should be replaced with given text.
    @objc optional func searchBar(_ searchBar: SearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    
    // Tells the delegate that the bookmark button was tapped.
    @objc optional func searchBarSearchButtonClicked(_ searchBar: SearchBar)
}

/// A specialized view for receiving search-related information from the user.
public class SearchBar: UIView, UITextFieldDelegate, AnyAppThemable {
    
    /// The search bar’s delegate object.
    public weak var delegate: SearchBarDelegate?
    
    /// The current or starting search text.
    public var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    /// The string that is displayed when there is no other text in the text field.
    public var placeholder: String? {
        get { return textField.text }
        set {
            textField.placeholder = newValue
            updatePlaceholder()
        }
    }

    /// The accessibility identifier
    public var accessibilityId: String? {
        get {
            return accessibilityIdentifier
        } set {
            accessibilityIdentifier = newValue
        }
    }

    /// The keyboard type for the text object.
    public var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    
    /// The visible title of the Return key.
    public var returnKeyType: UIReturnKeyType {
        get { return textField.returnKeyType }
        set { textField.returnKeyType = newValue }
    }
    
    /// The image that is displayed left text field.
    public var searchImage: UIImage? = Asset.System.Outline.searchOutline.image {
        didSet { updateSearchImageView() }
    }
    
    private let backgroundView = UIView()
    private let textField = UITextField()
    private let searchImageView = UIImageView()
    private let clearButton = UIButton(type: .system)
    
    private lazy var textFieldLeadingConstraint: NSLayoutConstraint = {
        let constraint = textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutGrid.halfModule * 3)
        constraint.isActive = false
        return constraint
    }()
    private lazy var textFieldLeadingSearchViewConstraint: NSLayoutConstraint = {
        let constraint = textField.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: LayoutGrid.halfModule * 3)
        constraint.isActive = true
        return constraint
    }()
    private lazy var searchImageWidthConstraint: NSLayoutConstraint = {
        let constraint = searchImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7)
        constraint.isActive = true
        return constraint
    }()
    
    private var scheme = SearchBarColorScheme() {
        didSet { updateScheme() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func apply(theme: AppTheme) {
        scheme = SearchBarColorScheme(theme: theme)
    }
    
    private func updateScheme() {
        backgroundView.backgroundColor = scheme.backgroundColor.uiColor
        textField.textColor = scheme.textColor.uiColor
        textField.tintColor = scheme.tintColor.uiColor
        searchImageView.tintColor = scheme.placeholderColor.uiColor
        clearButton.tintColor = scheme.placeholderColor.uiColor
        updatePlaceholder()
    }
    
    private func commonInit() {
        configureLayout()
        configureUI()
    }
    
    private func configureUI() {
        textField.delegate = self
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.returnKeyType = .search
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        searchImageView.image = searchImage
        searchImageView.contentMode = .center
        clearButton.setImage(Asset.Service.Solid.closeSolid.image, for: .normal)
        clearButton.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = LayoutGrid.module
        
        apply(theme: defaultTheme)
        updateClearButton()
        updateSearchImageView()
    }
    
    private func configureLayout() {
        [backgroundView].addToSuperview(self)
        [searchImageView, textField, clearButton].addToSuperview(backgroundView)
        
        let backgroundTop = backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module)
        let backgroundBottom = bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: LayoutGrid.module)
        backgroundTop.priority = .defaultHigh
        backgroundBottom.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            backgroundTop,
            backgroundBottom,
            backgroundView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.halfModule),
            trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: LayoutGrid.halfModule),
            backgroundView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 9),
            
            searchImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            searchImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutGrid.halfModule * 3),
            searchImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            searchImageWidthConstraint,
            
            textField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textFieldLeadingSearchViewConstraint,
            textFieldLeadingConstraint,
            
            clearButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            trailingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: LayoutGrid.halfModule * 3),
            clearButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: LayoutGrid.halfModule * 3),
            clearButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 3),
            clearButton.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 3)
        ])
    }
    
    @objc private func didTapClear() {
        textField.text = nil
        textFieldDidChange(textField)
    }
    
    private func updatePlaceholder() {
        guard let text = textField.placeholder else {
            textField.placeholder = nil
            return
        }
        
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [
            .foregroundColor: scheme.placeholderColor.uiColor,
            .font: scheme.placeholderFont.uiFont
        ])
    }
    
    private func updateClearButton() {
        clearButton.isHidden = textField.text?.nilIfEmpty == nil
    }
    
    private func updateSearchImageView() {
        searchImageView.image = searchImage
        
        let isSearchImageViewHidden = searchImage == nil
        searchImageView.isHidden = isSearchImageViewHidden
        
        textFieldLeadingSearchViewConstraint.isActive = !isSearchImageViewHidden
        searchImageWidthConstraint.isActive = !isSearchImageViewHidden
        textFieldLeadingConstraint.isActive = isSearchImageViewHidden
    }
    
    // MARK: - UITextFieldDelegate
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateClearButton()
        delegate?.searchBar?(self, textDidChange: textField.text ?? "")
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.searchBarShouldBeginEditing?(self) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.searchBarTextDidBeginEditing?(self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.searchBarShouldEndEditing?(self) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarTextDidEndEditing?(self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.searchBar?(self, shouldChangeTextIn: range, replacementText: string) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchBarSearchButtonClicked?(self)
        return true
    }
    
}
