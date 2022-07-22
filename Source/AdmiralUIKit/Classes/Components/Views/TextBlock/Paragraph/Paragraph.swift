//
//  Paragraph.swift
//  AdmiralUIResources
//
//  Created on 14.07.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public enum ParagraphStyle: String {
    case primary
    case secondary
}

/**
 Paragraph - A group of text components exists in several variants.

 You can create a ParagraphView by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - title: String? - The text that the label displays
 - paragraphType: ParagaphImageType? - A type of paragraph Image. Can be: point, check, custom (your image)
 - leadingImage: UImage? - Leading image.
 - trailingImage: UImage? - Trailing image.
 - paragraphStyle: ParagraphStyle - A style of Paragraph fount and text color. Can be primary or secondary.
 - textAligment: TextAlignment - Alignment text
 ## Example to create Paragraph with different parameters:
 # Code
 ```
 let pointParagraph = Paragraph()
 pointParagraph.title = titleSmallText
 pointParagraph.paragraphStyle = style
 pointParagraph.paragraphType = .point
 views.append(ParagraphCellView(paragraph: pointParagraph, titleText: titleText))
 
 let checkParagraph = Paragraph()
 checkParagraph.title = titleSmallText
 checkParagraph.paragraphStyle = style
 checkParagraph.paragraphType = .check
 views.append(ParagraphCellView(paragraph: checkParagraph))
 
 let leftParagraph = Paragraph()
 leftParagraph.title = titleLargeText
 leftParagraph.paragraphStyle = style
 views.append(ParagraphCellView(paragraph: leftParagraph, heightParagraph: LayoutGrid.doubleModule * 5))
 
 let rightParagraph = Paragraph()
 rightParagraph.title = titleLargeText
 rightParagraph.paragraphStyle = style
 rightParagraph.traillingImage = Asset.Card.info.image
 views.append(ParagraphCellView(paragraph: rightParagraph, heightParagraph: LayoutGrid.doubleModule * 5))
 
 let centrLargeParagraph = Paragraph()
 centrLargeParagraph.title = titleLargeText
 centrLargeParagraph.textAligment = .center
 centrLargeParagraph.paragraphStyle = style
 views.append(ParagraphCellView(paragraph: centrLargeParagraph, heightParagraph: LayoutGrid.doubleModule * 5))
 ```
*/

public class Paragraph: UIView, AnyAppThemable {
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var isEnabled: Bool = true {
        didSet { updateScheme()  }
    }
    
    /// The text that the label displays.
    public var title: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    
    /// A type of paragraph Image. Can be: point, check, custom (your image)
    public var paragraphType: ParagaphImageType? {
        didSet { leadingImage = paragraphType?.image}
    }
    
    /// Text aligment.
    public var textAligment: NSTextAlignment {
        get { return textLabel.textAlignment }
        set { textLabel.textAlignment = newValue }
    }
    
    ///  Leading image.
    public var leadingImage: UIImage? {
        didSet { updateLeadingImage() }
    }
    
    /// Trailling image.
    public var traillingImage: UIImage? {
        didSet { updateTaillingImage() }
    }
    
    /// Paragraph style.
    public var paragraphStyle: ParagraphStyle = .primary {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }
    
    // MARK: - Internal Properties
    
    var scheme = ParagraphScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let textLabel = UILabel()
    private let leadingImageView = UIImageView()
    private let traillingImageView = UIImageView()
    
    private lazy var leadingImageWidthConstraint: NSLayoutConstraint = {
        return leadingImageView.widthAnchor.constraint(equalToConstant: .zero)
    }()
    private lazy var trallingImageWidthConstraint: NSLayoutConstraint = {
        return traillingImageView.widthAnchor.constraint(equalToConstant: .zero)
    }()
    
    private lazy var textLableLeadingConstraint: NSLayoutConstraint = {
        return textLabel.leadingAnchor.constraint(equalTo: leadingImageView.trailingAnchor, constant: .zero)
    }()
    
    private lazy var textLableTaillingConstraint: NSLayoutConstraint = {
        return traillingImageView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: .zero)
    }()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience public init() {
        self.init(frame: CGRect())
        commonInit()
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
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = ParagraphScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [leadingImageView, textLabel, traillingImageView].addToSuperview(self)
    }
    
    private func configureUI() {
        textLabel.numberOfLines = 0
        leadingImageView.tintColor = scheme.leadingImageColor.uiColor
        leadingImageView.contentMode = .center
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            leadingImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            leadingImageWidthConstraint,
            leadingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leadingImageView.topAnchor.constraint(equalTo: topAnchor),
            
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule/2),
            textLableLeadingConstraint,
            textLableTaillingConstraint,
            
            traillingImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            trallingImageWidthConstraint,
            traillingImageView.topAnchor.constraint(equalTo: textLabel.topAnchor),
            traillingImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func updateScheme() {
        updateColors()
        updateFonts()
    }
    
    private func updateColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        textLabel.textColor = scheme.textColor.parameter(for: isEnabled ? .normal : .disabled, style: paragraphStyle)?.uiColor
    }

    private func updateFonts() {
        textLabel.setDynamicFont(
            font: scheme.titleFont.parameter(for: .normal, style: paragraphStyle)?.uiFont ?? scheme.defaultTitleFont.uiFont,
            textStyle: scheme.titleFont.parameter(for: .normal, style: paragraphStyle)?.textStyle ?? scheme.defaultTitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

    private func updateLeadingImage() {
        leadingImageView.image = leadingImage
        leadingImageWidthConstraint.constant = (leadingImage != nil ? LayoutGrid.tripleModule : .zero)
        textLableLeadingConstraint.constant = (leadingImage != nil ? LayoutGrid.doubleModule : .zero)
    }
    
    private func updateTaillingImage() {
        traillingImageView.image = traillingImage
        trallingImageWidthConstraint.constant = traillingImage != nil ? LayoutGrid.tripleModule : .zero
        textLableTaillingConstraint.constant = traillingImage != nil ? LayoutGrid.doubleModule : .zero
    }
    
}
