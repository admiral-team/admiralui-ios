//
//  PinCodeInput.swift
//  AdmiralUI
//
//  Created on 03.11.2020.
//

import UIKit
import AdmiralTheme

/// Control to input secure text pin code etc.
open class PinCodeInput: CodeInputControl, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    var scheme = PinCodeInputScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
        
    private var pinViewTheme: PinViewTheme {
        return PinViewTheme(
            backgroundColor: PinViewTheme.Background(
                default: scheme.defaultColor,
                active: scheme.activeColor,
                positive: scheme.successColor,
                error: scheme.errorColor)
        )
    }

    // MARK: - Public Methods
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func apply(theme: AppTheme) {
        self.scheme = PinCodeInputScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    override func createNewItem() -> CodeInputItemView {
        return PinCodeItemView()
    }
    
    override func updateColors() {
        super.updateColors()
        let theme = pinViewTheme
        
        codeViews
            .compactMap() { $0 as? PinCodeItemView }
            .forEach() { $0.apply(theme: theme) }
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        parameters.itemSize = CGSize(width: 12.0, height: 12.0)
    }
    
    private func updateScheme() {
        updateColors()
    }
    
}
