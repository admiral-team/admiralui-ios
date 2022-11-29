//
//  CheckControl.swift
//  AdmiralUI
//
//  Created on 20.10.2020.
//

import UIKit
import AdmiralTheme

public enum CheckControlState: Int {
    case normal
    case error
}

/**
 CheckControl - Base class for checkbox and radiobutton.
 
 The CheckControl has some internal properties for customizing the element:
 
 Internal Properties:
 - checkState: CheckControlState - State control.
 - isSelected: Bool - A Boolean value indicating whether the control is in the selected state.
 - isEnabled: Bool - A Boolean value indicating whether the control is in the enabled state.
 - isHighlighted: Bool - A Boolean value indicating whether the control is in the highlighted state.
*/

public class CheckControl: UIControl, AppThemeable {

    // MARK: - Constants

    private enum Constants {
        static let size = CGSize(width: LayoutGrid.tripleModule, height: LayoutGrid.tripleModule)
    }

    // MARK: - Public Parameters
    
    /// State control.
    public var checkState: CheckControlState = .normal {
        didSet { updateState() }
    }
            
    /// A Boolean value indicating whether the control is in the selected state.
    public override var isSelected: Bool {
        didSet { updateState() }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet { updateState() }
    }
    
    /// A Boolean value indicating whether the control is in the highlighted state.
    public override var isHighlighted: Bool {
        didSet { updateState() }
    }

    /// Color scheme.
    public var scheme = CheckControlScheme() {
        didSet { updateState() }
    }
    
    // MARK: - Internal Parameters
    
    /// Selected Image control.
    var selectedImage: UIImage = UIImage()
    
    /// Default Image control.
    var defaultImage: UIImage = UIImage()
    
    // MARK: - Private Parameters

    private let imageView = UIImageView()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override var intrinsicContentSize: CGSize {
        return Constants.size
    }
    
    // MARK: - Internal Methods
    
    func commonInit() {
        addSubviews()
        configureConstraints()
        apply(theme: defaultTheme)
    }
    
    func updateState() {
        switch checkState {
        case .normal:
            imageView.tintColor = scheme.normal.parameter(for: state)?.uiColor
        case .error:
            imageView.tintColor = scheme.error.parameter(for: state)?.uiColor
        }
        
        imageView.image = isSelected ? selectedImage : defaultImage
    }
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        scheme = CheckControlScheme(theme: theme)
    }
    
    // MARK: - Private Methods

    private func addSubviews() {
        [imageView].addToSuperview(self)
    }

    private func configureConstraints() {
        imageView.fillView(view: self).activate()
    }

}
