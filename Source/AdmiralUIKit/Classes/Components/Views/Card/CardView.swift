//
//  CardView.swift
//  AdmiralUI
//
//  Created on 25.12.2020.
//

import UIKit
import AdmiralTheme

/// The style of credit card status.
public enum CardStatusStyle: Int {
    /// The state when the card has no status
    case noStatus
    /// The default state of the card status
    case `default`
    /// The warning state of the card status
    case attention
    /// The error state of the card status
    case error
}

open class CardView: UIView, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// The text used for topLabel
    open var topLabelText: String? {
        get { return topLabel.text }
        set { topLabel.text = newValue }
    }
    
    /// The text used for nameLabel
    open var nameLabelText: String? {
        get { return nameLabel.text }
        set { nameLabel.text = newValue }
    }
    
    /// The text used for amountLabel
    open var amountLabelText: String? {
        get { return amountLabel.text }
        set { amountLabel.text = newValue }
    }
    
    /// The text used for statusLabel
    open var statusLabelText: String? {
        get { return statusLabel.text }
        set { statusLabel.text = newValue }
    }
    
    /// The text used for subtitleLabel
    open var subtitleLabelText: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    /// The font used for topLabel
    open var topLabelFont: UIFont? {
        get { return topLabel.font }
        set { topLabel.font = newValue }
    }
    
    /// The font used for nameLabel
    open var nameLabelFont: UIFont? {
        get { return nameLabel.font }
        set { nameLabel.font = newValue }
    }
    
    /// The font used for amountLabel
    open var amountLabelFont: UIFont? {
        get { return amountLabel.font }
        set { amountLabel.font = newValue }
    }
    
    /// The font used for statusLabel
    open var statusLabelFont: UIFont? {
        get { return statusLabel.font }
        set { statusLabel.font = newValue }
    }
    
    /// The font used for subtitleLabel
    open var subtitleLabelFont: UIFont? {
        get { return subtitleLabel.font }
        set { subtitleLabel.font = newValue }
    }
    
    /// The image used for credit card
    open var backgroundImage: UIImage? {
        get { return backgroundImageView.image }
        set {
            backgroundImageView.image = newValue
        }
    }
    
    /// The fitst image used for showing credit card payment system
    open var cardPaymentSystemSecondImage: UIImage? {
        get { return cardPaymentSystemSecondImageView.image }
        set {
            cardPaymentSystemSecondImageView.image = newValue
        }
    }
    
    /// The second image used for showing credit card payment system 
    open var cardPaymenSystemFirstImage: UIImage? {
        get { return cardPaymenSystemFirstImageView.image }
        set {
            cardPaymenSystemFirstImageView.image = newValue
        }
    }
    
    /// The image used for credit card status
    open var statusImage: UIImage? {
        get { return statusImageView.image }
        set {
            statusImageView.image = newValue
        }
    }
    
    /// The corner radius of view
    open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    /// The accessibility identifier
    public var accessibilityId: String? {
        get {
            return accessibilityIdentifier
        } set {
            accessibilityIdentifier = newValue
        }
    }
    
    var scheme = CardViewScheme() {
        didSet { configure() }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var cardStatusStyle: CardStatusStyle = .noStatus {
        didSet { configure() }
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
    
    // MARK: - Private Propeties
    
    private let topLabel = UILabel()
    private let nameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let statusImageView = UIImageView()
    private let statusBackGroundView = UIView()
    private let statusLabel = UILabel()
    private let amountLabel = UILabel()
    private let cardPaymenSystemFirstImageView = UIImageView()
    private let cardPaymentSystemSecondImageView = UIImageView()
    private let subtitleLabel = UILabel()
    
    // MARK: - AppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = CardViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        switch cardStatusStyle {
        case .noStatus:
            statusLabel.isHidden = true
            statusImageView.isHidden = true
        default:
            statusLabel.isHidden = false
            statusImageView.isHidden = false
        }
        
        topLabel.textColor = scheme.topLabelTextColor.uiColor
        amountLabel.textColor = scheme.amountLabelTextColor.uiColor
        nameLabel.textColor = scheme.nameLabelTextColor.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.uiColor
        statusLabel.textColor = scheme.statusLabelTextColors.parameter(style: cardStatusStyle)?.uiColor
        statusImageView.tintColor = scheme.statusImageViewColors.parameter(style: cardStatusStyle)?.uiColor
        statusBackGroundView.backgroundColor = scheme.statusBackGroundViewColors.parameter(style: cardStatusStyle)?.uiColor
        
        topLabel.font = scheme.topLabelFont
        nameLabel.font = scheme.nameLabelFont
        amountLabel.font = scheme.amountLabelFont
        statusLabel.font = scheme.statusLabelFont
    }
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        setupLabels()
        addSubviews()
        setupViews()
        setupImageViews()
        configureConstraints()
    }
    
    private func addSubviews() {
        [backgroundImageView].addToSuperview(self)
        [amountLabel,
         subtitleLabel,
         cardPaymenSystemFirstImageView,
         cardPaymentSystemSecondImageView,
         statusBackGroundView].addToSuperview(backgroundImageView)
        
        [topLabel,
         nameLabel,
         statusLabel,
         statusImageView].addToSuperview(statusBackGroundView)
    }
    
    private func setupViews() {
        layer.cornerRadius = LayoutGrid.doubleModule
        layer.masksToBounds = true
    }
    
    private func setupLabels() {
        topLabel.numberOfLines = 1
        topLabel.textAlignment = .left
        
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        
        amountLabel.numberOfLines = 1
        amountLabel.textAlignment = .left
        
        statusLabel.numberOfLines = 1
        statusLabel.textAlignment = .left
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .left
    }
    
    private func setupImageViews() {
        backgroundImageView.contentMode = .scaleAspectFit
        cardPaymenSystemFirstImageView.contentMode = .scaleAspectFit
        cardPaymentSystemSecondImageView.contentMode = .scaleAspectFit
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            amountLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: LayoutGrid.doubleModule),
            backgroundImageView.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            backgroundImageView.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: LayoutGrid.module * 5),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: LayoutGrid.doubleModule),
            backgroundImageView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            amountLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.module),
            
            cardPaymenSystemFirstImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: LayoutGrid.doubleModule),
            cardPaymenSystemFirstImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 4),
            cardPaymenSystemFirstImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            cardPaymenSystemFirstImageView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            
            cardPaymentSystemSecondImageView.leadingAnchor.constraint(equalTo: cardPaymenSystemFirstImageView.trailingAnchor, constant: LayoutGrid.halfModule),
            cardPaymentSystemSecondImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 4),
            cardPaymentSystemSecondImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule),
            cardPaymentSystemSecondImageView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            
            statusBackGroundView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            statusBackGroundView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            statusBackGroundView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            statusBackGroundView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            
            topLabel.leadingAnchor.constraint(equalTo: statusBackGroundView.leadingAnchor, constant: LayoutGrid.doubleModule),
            topLabel.topAnchor.constraint(equalTo: statusBackGroundView.topAnchor, constant: LayoutGrid.halfModule * 5),
            statusBackGroundView.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            nameLabel.leadingAnchor.constraint(equalTo: statusBackGroundView.leadingAnchor, constant: LayoutGrid.doubleModule),
            statusBackGroundView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            nameLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: LayoutGrid.halfModule / 2),
            
            statusImageView.leadingAnchor.constraint(equalTo: statusBackGroundView.leadingAnchor, constant: LayoutGrid.doubleModule),
            statusBackGroundView.bottomAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: LayoutGrid.halfModule * 3),
            statusImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            statusImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            
            statusLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: LayoutGrid.halfModule),
            statusLabel.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor),
            statusBackGroundView.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
}
