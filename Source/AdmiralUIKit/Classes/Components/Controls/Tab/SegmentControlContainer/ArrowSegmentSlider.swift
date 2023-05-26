//
//  ArrowSegmentSlider.swift
//  AdmiralUI
//
//  Created on 06.11.2020.
//

import UIKit
import AdmiralTheme

class ArrowSegmentSlider: UIView, AnyAppThemable {
    
    enum Constants {
        static let height: CGFloat = LayoutGrid.halfModule * 3
        static let arrowImage = Asset.System.Outline.arrowUpOutline.image
        static let widthImageView: CGFloat = LayoutGrid.quadrupleModule
    }
    
    var scheme = ArrowSegmentSliderCustomTheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Public Properties
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }
    
    // MARK: - Private Properties
    
    private let arrowImageView = UIImageView()
    private var leadingArrowConstraint: NSLayoutConstraint!
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object.
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = ArrowSegmentSliderCustomTheme(theme: theme)
    }
    
    // MARK: - Public Methods
    
    public func setOffset(_ offset: CGFloat, animated: Bool) {
        leadingArrowConstraint.constant = offset - Constants.widthImageView / 2
        if animated {
            UIView.animate(
                withDuration: Durations.Default.single,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.layoutIfNeeded()
                },
                completion: nil)
        } else {
            layoutIfNeeded()
        }
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [arrowImageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        leadingArrowConstraint = arrowImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        NSLayoutConstraint.activate([
            arrowImageView.topAnchor.constraint(equalTo: topAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 3),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constants.widthImageView),
            leadingArrowConstraint
        ])
    }
    
    private func configureUI() {
        arrowImageView.image = Constants.arrowImage
    }
    
    private func updateScheme() {
        backgroundColor = scheme.backgroundColor.uiColor
        arrowImageView.tintColor = scheme.imageTintColor.uiColor
    }
    
}
