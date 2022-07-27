//
//  ShimmerCellView.swift
//  ExampleiOS
//
//  Created on 16.12.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

enum ShimmerCellViewState {
    case leftImageShimmering
    case rightImageShimmering
    case subtitleShimmering
    case wholeViewShimmering
}

final class ShimmerCellView: UIView, AnyAppThemable {
    
    // MARK: - Private Properties
    
    private let cardImageView = UIImageView()
    private let cardImageViewShimmerView = ShimmeringView()
    
    private let titleLabel = UILabel()
    
    private let subtitleLabel = UILabel()
    private let subtitleShimmerView = ShimmeringView()
    
    private let tralingImageView = UIImageView()
    private let tralingImageViewShimmerView = ShimmeringView()
    
    private let contentViewShimmeringView = ShimmeringView()
    private lazy var subtitleHeightContraint: NSLayoutConstraint = {
        subtitleShimmerView.heightAnchor.constraint(equalToConstant: subtitleLabel.font.pointSize)
    }()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        subtitleHeightContraint.constant = subtitleLabel.font.pointSize
    }
    
    init(state: ShimmerCellViewState) {
        super.init(frame: .zero)
        configureUI()
        setShimmer(state: state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        titleLabel.setDynamicFont(
            font: theme.fonts.body1.uiFont,
            textStyle: theme.fonts.body1.textStyle
        )
        subtitleLabel.setDynamicFont(
            font: theme.fonts.subtitle2.uiFont,
            textStyle: theme.fonts.subtitle2.textStyle
        )
        titleLabel.textColor = theme.colors.textPrimary.uiColor
        subtitleLabel.textColor = theme.colors.textAccent.uiColor
        subtitleShimmerView.apply(theme: theme)
        contentViewShimmeringView.apply(theme: theme)
        tralingImageViewShimmerView.apply(theme: theme)
        cardImageViewShimmerView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        addSubviews()
        setTitleLabel()
        setImageViews()
        configureLayout()
        setShimmeringViews()
    }
    
    private func setTitleLabel() {
        titleLabel.text = "Зарплатная карта"
        titleLabel.textAlignment = .left
        
        subtitleLabel.text = "66 800.00 ₽"
        subtitleLabel.textAlignment = .left
    }
    
    private func setImageViews() {
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.image = Asset.Card.visa.image
        
        tralingImageView.contentMode = .scaleAspectFit
        tralingImageView.image = Asset.Card.mir.image
    }
    
    private func setShimmeringViews() {
        cardImageViewShimmerView.isHidden = true
        tralingImageViewShimmerView.isHidden = true
        subtitleShimmerView.isHidden = true
        contentViewShimmeringView.isHidden = true
    }
    
    private func setShimmer(state: ShimmerCellViewState) {
        switch state {
        case .leftImageShimmering:
            cardImageView.isHidden = true
            cardImageViewShimmerView.isHidden = false
            cardImageViewShimmerView.layer.cornerRadius = 2.0
            cardImageViewShimmerView.clipsToBounds = true
            cardImageViewShimmerView.start()
        case .rightImageShimmering:
            tralingImageView.isHidden = true
            tralingImageViewShimmerView.isHidden = false
            tralingImageViewShimmerView.layer.cornerRadius = 2.0
            tralingImageViewShimmerView.clipsToBounds = true
            tralingImageViewShimmerView.start()
        case .subtitleShimmering:
            subtitleLabel.isHidden = true
            subtitleShimmerView.isHidden = false
            subtitleShimmerView.layer.cornerRadius = 2.0
            subtitleShimmerView.clipsToBounds = true
            subtitleShimmerView.start()
        case .wholeViewShimmering:
            titleLabel.isHidden = true
            cardImageView.isHidden = true
            tralingImageView.isHidden = true
            subtitleLabel.isHidden = true
            contentViewShimmeringView.isHidden = false
            contentViewShimmeringView.layer.cornerRadius = 2.0
            contentViewShimmeringView.clipsToBounds = true
            contentViewShimmeringView.start()
        }
    }
    
    private func addSubviews() {
        [cardImageView,
         titleLabel,
         tralingImageView,
         subtitleLabel,
         cardImageViewShimmerView,
         tralingImageViewShimmerView,
         subtitleShimmerView,
         contentViewShimmeringView
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            cardImageView.heightAnchor.constraint(equalToConstant: 28.0),
            cardImageView.widthAnchor.constraint(equalToConstant: 38.0),
            cardImageView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 5),
            
            cardImageViewShimmerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            cardImageViewShimmerView.heightAnchor.constraint(equalToConstant: 28.0),
            cardImageViewShimmerView.widthAnchor.constraint(equalToConstant: 38.0),
            cardImageViewShimmerView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 5),
            
            titleLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 3),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            tralingImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            tralingImageView.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.module),
            
            subtitleShimmerView.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            subtitleShimmerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleShimmerView.widthAnchor.constraint(equalToConstant: 108.0),
            subtitleHeightContraint,
            
            trailingAnchor.constraint(equalTo: tralingImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            tralingImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tralingImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            tralingImageView.widthAnchor.constraint(equalToConstant: 28.0),
            
            trailingAnchor.constraint(equalTo: tralingImageViewShimmerView.trailingAnchor, constant: LayoutGrid.doubleModule),
            tralingImageViewShimmerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tralingImageViewShimmerView.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            tralingImageViewShimmerView.widthAnchor.constraint(equalToConstant: 28.0),
            
            heightAnchor.constraint(equalToConstant: 68.0),

            contentViewShimmeringView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: contentViewShimmeringView.trailingAnchor, constant: LayoutGrid.doubleModule),
            contentViewShimmeringView.topAnchor.constraint(equalTo: topAnchor),
            contentViewShimmeringView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
