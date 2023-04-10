//
//  ThemeSwitchButton.swift
//  ExampleiOS
//
//  Created on 22.03.2021.
//

import AdmiralUIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

protocol ThemeSwitchButtonDelegate: AnyObject {
    func buttonTapped(isSelected: Bool)
}

class ThemeSwitchButton: UIButton, AnyAppThemable {
            
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundExtraSurface.uiColor
        
        tintColor = theme.colors.elementExtra.uiColor
        
        layer.shadowColor = theme.colors.backgroundShadow.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.0, height: LayoutGrid.halfModule)
        layer.shadowRadius = LayoutGrid.module
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        setImage(Asset.Main.ellipse.image, for: .normal)
        setImage(Asset.Main.closeOutline.image, for: .selected)
    }
    
}
