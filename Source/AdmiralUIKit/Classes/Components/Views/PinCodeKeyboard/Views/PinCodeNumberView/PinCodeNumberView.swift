//
//  PinCodeNumberView.swift
//  AdmiralUIResources
//
//  Created on 26.04.2021.
//

import UIKit
import AdmiralTheme

public struct PinCodeNumber {
    let state: PinCodeNumberViewState

    public init(state: PinCodeNumberViewState) {
        self.state = state
    }
}

public struct PinCodeNumberAction {
    let title: String?
    let image: UIImage?
}

public enum PinCodeNumberViewState {
    case number(Int)
    case rightAction(PinCodeNumberAction?)
}
 
final public class PinCodeNumberView: UIControl, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    public override var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    public override var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    public override var isHighlighted: Bool {
        didSet { updateScheme() }
    }
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    var scheme = PinCodeNumberCustomScheme() {
        didSet { updateScheme() }
    }
    
    var viewState: PinCodeNumberViewState? {
        didSet { updateView() }
    }
        
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let contentView = UIView()
    private let imageView = UIImageView()

    // MARK: - Internal Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.isUserInteractionEnabled = false
        contentView.isUserInteractionEnabled = false
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = PinCodeNumberCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupConstraints()
        configureUI()
    }
    
    private func addSubviews() {
        [contentView].addToSuperview(self)
        [titleLabel, imageView].addToSuperview(contentView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 15),
            contentView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 15),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 9),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 9),
        ])
    }
    
    private func configureUI() {
        titleLabel.textAlignment = .center
        updateScheme()
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.font = scheme.textFont
    }
    
    private func updateSchemeColors() {
        backgroundColor = .clear
        titleLabel.textColor = scheme.textColor.uiColor
        imageView.tintColor = scheme.imageColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
    }
    
    private func prepareActionModel(model: PinCodeNumberAction?) {
        guard
            let model = model
        else {
            isUserInteractionEnabled = false
            return
        }
        
        if model.image != nil {
            imageView.isHidden = false
            imageView.image = model.image
        } else {
            imageView.isHidden = true
            titleLabel.text = model.title
        }
    }
    
    private func updateView() {
        guard let viewState = viewState else { return }
        
        switch viewState {
        case .number(let number):
            imageView.isHidden = true
            title = String(number)
        case .rightAction(let model):
            prepareActionModel(model: model)
        }
        updateScheme()
    }
    
}
