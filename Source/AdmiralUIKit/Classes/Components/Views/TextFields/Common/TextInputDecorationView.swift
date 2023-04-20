//
//  TextInputDecorationView.swift
//  AdmiralUI
//
//  Created on 10.03.2021.
//

import UIKit
import AdmiralUIResources
import AdmiralTheme

final class TextInputDecorationView: UIView, AnyAppThemable, AccessibilitySupport {
    
    enum TrailingViewAlignmentStyle {
        case bottom(offset: CGFloat)
        case center(offset: CGFloat)
        case centerText(offset: CGFloat)
    }
    
    struct LayoutParameters {
        var nameLabelHeight: CGFloat = LayoutGrid.doubleModule
        var textInputSpacingTop: CGFloat = LayoutGrid.module
        var textInputMinHeight: CGFloat = 5 * LayoutGrid.halfModule
        var textInputSpacingLeading: CGFloat = .zero
        var placeholderSpacingLeading: CGFloat = LayoutGrid.halfModule - 2
        var placeholderSpacingTop: CGFloat = .zero
        var additionalViewSpacingTop: CGFloat = LayoutGrid.module
        var additionalViewSpacingBottom: CGFloat = LayoutGrid.module
        var separatorSpacingTop: CGFloat = LayoutGrid.halfModule
        var separtorBoxHeight: CGFloat = LayoutGrid.halfModule
        var infoLabelSpacingTop: CGFloat = LayoutGrid.module
        var trailingViewAlignmentStyle: TrailingViewAlignmentStyle = .centerText(offset: 0)
        var trailingViewSpacingLeading: CGFloat = LayoutGrid.module
        var trailingViewSize: CGSize = CGSize(width: 3 * LayoutGrid.module, height: 3 * LayoutGrid.module)
        var leadingTextSpacing: CGFloat = LayoutGrid.module

        fileprivate var textInputTopOffset: CGFloat {
            return nameLabelHeight + textInputSpacingTop
        }
        
        fileprivate var textBoxMinHeight: CGFloat {
            return textInputTopOffset + textInputMinHeight + separatorSpacingTop + separtorBoxHeight
        }
    }

    var name: String? {
        get { return nameLabel.text }
        set {
            nameLabel.text = newValue
            updateState()
        }
    }
    
    var info: String? {
        get { return informerLabel.text }
        set {
            informerLabel.text = newValue
            updateLayoutConstraints()
        }
    }
    
    var placeholder: String? {
        get { return placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }

    var leadingText: String? {
        get { return leadingTextLabel.text }
        set { leadingTextLabel.text = newValue }
    }

    var trailingView: UIView? {
        didSet { updateTrailingView(oldView: oldValue) }
    }
    
    var additionalView: UIView? {
        didSet { updateAAdditionalView(oldView: oldValue)}
    }

    var isOpened: Bool = false {
        didSet {
            updateState()
            updateScheme()
        }
    }

    var enablePlaceholderOffset: Bool = true {
        didSet { updateLayoutConstraints() }
    }
    
    var isTrailingTextField: Bool = false {
        didSet { updateLayoutConstraints() }
    }
    
    var nameLabelMinFont: UIFont? {
        didSet { layoutIfNeeded() }
    }
    
    var layoutParameters = LayoutParameters() {
        didSet { updateLayoutConstraints() }
    }
    
    var scheme = TextInputDecorationViewScheme() {
        didSet { updateScheme() }
    }

    var leftLabelWidth: CGFloat? {
        didSet { updateLayoutConstraints() }
    }

    var leadingLabelSpacing: CGFloat = LayoutGrid.module {
        didSet {
            textLabelLeadingConstraint?.constant = leadingLabelSpacing + LayoutGrid.halfModule
        }
    }

    let textInput: UIView
    
    let nameLabel = UILabel()
    let placeholderLabel = UILabel()
    let informerLabel = UILabel()
    let leadingTextLabel = UILabel()
    let separatorView = SeparatorView()
    let tapAreaView = UIView()
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let trailingViewLayoutGuide = UILayoutGuide()
    private let textBoxLayoutGuide = UILayoutGuide()
    private let additionViewLayoutGuide = UILayoutGuide()

    private var textInputTopConstraint: NSLayoutConstraint?
    private var textInputHeightConstraint: NSLayoutConstraint?
    private var textInputLeadingConstraing: NSLayoutConstraint?
    
    private var placeholderHeightConstraint: NSLayoutConstraint?
    private var placeholderSpacingLeadingConstraint: NSLayoutConstraint?
    private var placeholderSpacingTrailingConstraint: NSLayoutConstraint?
    private var placeholderSpacingTopConstraint: NSLayoutConstraint?

    private var textLabelTopConstraint: NSLayoutConstraint?
    private var textLabelLeadingConstraint: NSLayoutConstraint?
    private var textLabelTrailingConstraint: NSLayoutConstraint?

    private var separatorSpacingTopConstraint: NSLayoutConstraint?
    private var separtorBoxHeightConstraint: NSLayoutConstraint?
    
    private var infoLabelSpacingTopConstraint: NSLayoutConstraint?
    
    private var additionalViewSpacingTopConstraint: NSLayoutConstraint?
    
    private var trailingViewSpacingBottomConstraint: NSLayoutConstraint?
    private var trailingViewCenterConstraint: NSLayoutConstraint?
    private var trailingViewCenterTextConstraint: NSLayoutConstraint?

    private var trailingViewSpacingLeadingConstraint: NSLayoutConstraint?
    private var trailingViewHeightConstraint: NSLayoutConstraint?
    private var trailingViewWidthConstraint: NSLayoutConstraint?

    init(textInput: UIView) {
        self.textInput = textInput
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutNameLabel()
    }
    
    func apply(theme: AppTheme) {
        scheme = TextInputDecorationViewScheme(theme: theme)
    }
    
    private func updateScheme() {
        nameLabel.setDynamicFont(
            font: isOpened ? scheme.nameFont.uiFont : scheme.nameEnableFont.uiFont,
            textStyle: scheme.nameFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        placeholderLabel.setDynamicFont(
            font: scheme.placeholderFont.uiFont,
            textStyle: scheme.placeholderFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        informerLabel.setDynamicFont(
            font: scheme.informerFont.uiFont,
            textStyle: scheme.informerFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        nameLabelMinFont = scheme.nameLabelMinFont.uiFont
        leadingTextLabel.setDynamicFont(
            font: scheme.leadingTextFont.uiFont,
            textStyle: scheme.leadingTextFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        addLayoutGuide(textBoxLayoutGuide)
        addLayoutGuide(trailingViewLayoutGuide)
        addLayoutGuide(additionViewLayoutGuide)
        
        tapAreaView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tapAreaView)
        
        textInput.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textInput)
        
        placeholderLabel.isUserInteractionEnabled = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        
        nameLabel.isUserInteractionEnabled = false
        addSubview(nameLabel)
        
        separatorView.isUserInteractionEnabled = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)
        
        informerLabel.isUserInteractionEnabled = false
        informerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(informerLabel)

        leadingTextLabel.isUserInteractionEnabled = false
        leadingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leadingTextLabel)
    }
    
    private func configureUI() {
        clipsToBounds = true
                
        nameLabel.layer.anchorPoint = .zero
        nameLabel.numberOfLines = 1
        
        informerLabel.numberOfLines = 0
                
        nameLabel.backgroundColor = .clear
        placeholderLabel.backgroundColor = .clear
        informerLabel.backgroundColor = .clear
        separatorView.backgroundColor = .clear
        tapAreaView.backgroundColor = .clear
        leadingTextLabel.backgroundColor = .clear
                
        updateState()
    }
    
    private func updateState() {
        setNeedsLayout()
    }
    
    private func configureLayout() {
        apply(theme: .default)
        configureTextBoxLayoutGuide()
        configureSeparatorLayout()
        configureTextInputLayout()
        configurePlaceholderLayout()
        configureAdditionalViewLayoutGuide()
        configureInformerLabelLayout()
        configureTrailingViewLayoutGuide()
        configureTapAreaViewLayout()
        configureLeadingTextLabelLayout()
        updateLayoutConstraints()
    }
    
    private func updateLayoutConstraints() {
        textInputTopConstraint?.constant = layoutParameters.textInputTopOffset
        textInputHeightConstraint?.constant = layoutParameters.textInputMinHeight
        placeholderHeightConstraint?.constant = layoutParameters.textInputMinHeight
        separatorSpacingTopConstraint?.constant = layoutParameters.separatorSpacingTop
        separtorBoxHeightConstraint?.constant = layoutParameters.separtorBoxHeight
        textInputLeadingConstraing?.constant = layoutParameters.textInputSpacingLeading
        placeholderSpacingTopConstraint?.constant = layoutParameters.placeholderSpacingTop
        
        if isTrailingTextField {
            textLabelTrailingConstraint?.isActive = true
            textLabelLeadingConstraint = leadingTextLabel.leadingAnchor.constraint(equalTo: textInput.trailingAnchor, constant: LayoutGrid.halfModule)
        } else {
            textLabelTrailingConstraint?.isActive = false
        }
        
        if enablePlaceholderOffset {
            if let leftLabelWidth = leftLabelWidth {
                textLabelLeadingConstraint?.isActive = false
                placeholderSpacingLeadingConstraint?.constant = layoutParameters.placeholderSpacingLeading + leftLabelWidth
            } else {
                textLabelLeadingConstraint?.isActive = false
                placeholderSpacingLeadingConstraint?.constant = layoutParameters.placeholderSpacingLeading
            }
        } else {
            textLabelLeadingConstraint?.isActive = true
            placeholderSpacingLeadingConstraint?.constant = 0
        }

        if trailingView == nil {
            trailingViewSpacingLeadingConstraint?.constant = 0
            trailingViewHeightConstraint?.constant = 0
            trailingViewWidthConstraint?.constant = 0
        } else {
            trailingViewSpacingLeadingConstraint?.constant = layoutParameters.trailingViewSpacingLeading
            trailingViewHeightConstraint?.constant = layoutParameters.trailingViewSize.height
            trailingViewWidthConstraint?.constant = layoutParameters.trailingViewSize.width
        }
        
        switch layoutParameters.trailingViewAlignmentStyle {
        case .bottom(let offset):
            trailingViewSpacingBottomConstraint?.constant = offset
            trailingViewSpacingBottomConstraint?.isActive = true
            trailingViewCenterTextConstraint?.isActive = false
            trailingViewCenterConstraint?.isActive = false
        case .center(let offset):
            trailingViewCenterConstraint?.constant = offset
            trailingViewCenterConstraint?.isActive = true
            trailingViewCenterTextConstraint?.isActive = false
            trailingViewSpacingBottomConstraint?.isActive = false
        case .centerText(let offset):
            trailingViewCenterTextConstraint?.constant = offset
            trailingViewCenterTextConstraint?.isActive = true
            trailingViewSpacingBottomConstraint?.isActive = false
            trailingViewCenterConstraint?.isActive = false
        }
        
        if additionalView == nil {
            additionalViewSpacingTopConstraint?.constant = 0
        } else {
            additionalViewSpacingTopConstraint?.constant = layoutParameters.additionalViewSpacingTop
        }
        
        if informerLabel.text?.nilIfEmpty == nil {
            infoLabelSpacingTopConstraint?.constant = 0
        } else {
            infoLabelSpacingTopConstraint?.constant = layoutParameters.infoLabelSpacingTop
        }
    }
    
    private func configureTextBoxLayoutGuide() {
        let top = textBoxLayoutGuide.topAnchor.constraint(equalTo: topAnchor)
        let leading = textBoxLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = textBoxLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func configureTextInputLayout() {
        let top = textInput.topAnchor.constraint(equalTo: textBoxLayoutGuide.topAnchor)
        let bottom = textInput.bottomAnchor.constraint(equalTo: textBoxLayoutGuide.bottomAnchor)
        let leading = textInput.leadingAnchor.constraint(equalTo: textBoxLayoutGuide.leadingAnchor)
        let trailing = textInput.trailingAnchor.constraint(equalTo: textBoxLayoutGuide.trailingAnchor)
        let height = textInput.heightAnchor.constraint(equalToConstant: 0)
        height.priority = UILayoutPriority(UILayoutPriority.defaultHigh.rawValue + 1)
        
        textInputTopConstraint = top
        textInputHeightConstraint = height
        textInputLeadingConstraing = leading
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing, height])
    }
    
    private func configureSeparatorLayout() {
        let top = separatorView.topAnchor.constraint(equalTo: textBoxLayoutGuide.bottomAnchor)
        let leading = separatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let height = separatorView.heightAnchor.constraint(equalToConstant: 0)
        
        separatorSpacingTopConstraint = top
        separtorBoxHeightConstraint = height
        
        NSLayoutConstraint.activate([top, leading, trailing, height])
    }
    
    private func configureTrailingViewLayoutGuide() {
        let trailing = trailingAnchor.constraint(equalTo: trailingViewLayoutGuide.trailingAnchor)
        let leading = trailingViewLayoutGuide.leadingAnchor.constraint(equalTo: textBoxLayoutGuide.trailingAnchor)
        let width = trailingViewLayoutGuide.widthAnchor.constraint(equalToConstant: 0)
        let height = trailingViewLayoutGuide.heightAnchor.constraint(equalToConstant: 0)

        let bottom = separatorView.topAnchor.constraint(equalTo: trailingViewLayoutGuide.bottomAnchor)
        let center = trailingViewLayoutGuide.centerYAnchor.constraint(equalTo: textBoxLayoutGuide.centerYAnchor)
        let centerText = trailingViewLayoutGuide.centerYAnchor.constraint(equalTo: textInput.centerYAnchor)
        trailing.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)

        trailingViewSpacingBottomConstraint = bottom
        trailingViewCenterConstraint = center
        trailingViewCenterTextConstraint = centerText

        trailingViewSpacingLeadingConstraint = leading
        trailingViewHeightConstraint = height
        trailingViewWidthConstraint = width

        NSLayoutConstraint.activate([trailing, leading, width, height])
    }

    private func configurePlaceholderLayout() {
        let top = placeholderLabel.topAnchor.constraint(equalTo: textInput.topAnchor)
        let leading = placeholderLabel.leadingAnchor.constraint(equalTo: textInput.leadingAnchor)
        let trailing = leadingTextLabel.leadingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor, constant: LayoutGrid.halfModule)
        let height = placeholderLabel.heightAnchor.constraint(equalToConstant: 0)

        placeholderSpacingLeadingConstraint = leading
        placeholderHeightConstraint = height
        placeholderSpacingTopConstraint = top
        placeholderSpacingTrailingConstraint = trailing

        NSLayoutConstraint.activate([top, leading, trailing, height])
    }

    private func configureLeadingTextLabelLayout() {
        let top = leadingTextLabel.topAnchor.constraint(equalTo: textInput.topAnchor)
        let leading = leadingTextLabel.leadingAnchor.constraint(equalTo: textInput.leadingAnchor)
        let trailing = leadingTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        textLabelLeadingConstraint = leading
        textLabelTrailingConstraint = trailing

        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func configureAdditionalViewLayoutGuide() {
        let leading = additionViewLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor)
        let top = additionViewLayoutGuide.topAnchor.constraint(equalTo: separatorView.topAnchor)
        let trailing = additionViewLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)

        additionalViewSpacingTopConstraint = top

        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func configureInformerLabelLayout() {
        let top = informerLabel.topAnchor.constraint(equalTo: additionViewLayoutGuide.bottomAnchor)
        let leading = informerLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = trailingAnchor.constraint(equalTo: informerLabel.trailingAnchor)
        let bottom = informerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        bottom.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        informerLabel.setContentHuggingPriority(.required, for: .vertical)
        
        infoLabelSpacingTopConstraint = top
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    private func configureTapAreaViewLayout() {
        let top = tapAreaView.topAnchor.constraint(equalTo: textBoxLayoutGuide.topAnchor)
        let bottom = tapAreaView.bottomAnchor.constraint(equalTo: textBoxLayoutGuide.bottomAnchor)
        let leading = tapAreaView.leadingAnchor.constraint(equalTo: textBoxLayoutGuide.leadingAnchor)
        let trailing = tapAreaView.trailingAnchor.constraint(equalTo: textBoxLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    private func layoutNameLabel() {
        nameLabel.sizeToFit()
        
        let offsetX: CGFloat = -1.0 / UIScreen.main.scale
        let textBoxHeight = layoutParameters.textBoxMinHeight
        let separatorSpacingTop = layoutParameters.separatorSpacingTop
        let separtorBoxHeight = layoutParameters.separtorBoxHeight

        if isOpened {
            let pointSize = nameLabel.font.pointSize
            let nameLabelMinFont = pointSize
            let scale = nameLabelMinFont / pointSize
            nameLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
            nameLabel.frame.origin.x = offsetX
            nameLabel.frame.origin.y = 0
        } else {
            nameLabel.transform = .identity
            nameLabel.frame.origin.x = offsetX
            nameLabel.frame.origin.y = textBoxHeight - separatorSpacingTop - separtorBoxHeight - nameLabel.frame.height
        }

        nameLabel.frame.size.width = min(nameLabel.frame.width, frame.width)
    }
    
    private func updateTrailingView(oldView: UIView?) {
        oldView?.removeFromSuperview()
        
        if let view = trailingView {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(view.fillGuide(guide: trailingViewLayoutGuide))
        }
        
        updateLayoutConstraints()
    }
    
    private func updateAAdditionalView(oldView: UIView?) {
        oldView?.removeFromSuperview()
        
        if let view = additionalView {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(view.fillGuide(guide: additionViewLayoutGuide))
        }
        
        updateLayoutConstraints()
    }

}
