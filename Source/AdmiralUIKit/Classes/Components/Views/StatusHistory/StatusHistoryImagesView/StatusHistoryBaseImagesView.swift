//
//  StatusHistoryBaseImagesView.swift
//  AdmiralUI
//
//  Created on 22.12.2020.
//

import UIKit
import AdmiralTheme

class StatusHistoryBaseImagesView: UIView, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    var images: [UIImage] = [] {
        didSet { setImageViews() }
    }
    
    var imageViewSize = CGSize(width: LayoutGrid.doubleModule * 3, height: LayoutGrid.doubleModule * 3) {
        didSet {
            heightConstraint.constant = imageViewSize.height + LayoutGrid.doubleModule * 2
            setImageViews()
        }
    }
    
    var scheme = StatusHistoryBaseImagesViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private var imageViews = [UIImageView]()
    private lazy var heightConstraint: NSLayoutConstraint = {
        return heightAnchor.constraint(equalToConstant: imageViewSize.height + LayoutGrid.doubleModule * 2)
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    
    func apply(theme: AppTheme) {
        scheme = StatusHistoryBaseImagesViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        configureUI()
    }
    
    private func updateScheme() {
        for imageView in imageViews {
            imageView.backgroundColor = scheme.imageViewBackgroundColor.uiColor
            imageView.layer.borderColor = scheme.imageViewBorderColor.cgColor
        }
    }
    
    private func configureUI() {
        configureHeightLayout()
    }
    
    private func configureHeightLayout() {
        NSLayoutConstraint.activate([
            heightConstraint
        ])
    }
    
    private func setImageViews() {
        imageViews.forEach({ $0.removeFromSuperview() })
        imageViews = []
        
        for index in (0..<images.count).reversed() {
            let image = images[index]
            let imageView = UIImageView(image: image)
            imageViews.append(imageView)
            
            imageView.contentMode = .scaleAspectFit
            
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageViewSize.width / 2
            imageView.layer.borderWidth = 2
            
            addImageView(imageView)
            configureConstraint(imageView, index: index)
        }
        updateScheme()
    }
    
    private func addImageView(_ view: UIView) {
        [view].addToSuperview(self)
    }
    
    private func configureConstraint(_ imageView: UIView, index: Int) {
        let count = images.count
        var offset: CGFloat = 0
        if count % 2 != 0 {
            offset = (imageViewSize.width / 2) * CGFloat(index - count / 2)
        } else {
            offset = (imageViewSize.width / 4) * CGFloat(index - (count - index - 1))
        }
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offset),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: imageViewSize.height),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize.width)
        ])
    }
}
