//
//  LogoSegmentedScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct LogoSegmentedScheme {
    
    struct ItemScheme {
        var alpha = ControlParameter<CGFloat>()
        var borderColor = ControlParameter<AColor>()
    }
    
    var itemScheme = ItemScheme()
    
    var borderColor = ControlParameter<AColor>()
    var thumbColor = ControlParameter<AColor>()
    
    init() {
        //
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.alpha.set(parameter: 1.0, for: [.selected, .disabled])
        itemScheme.borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)

        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        itemScheme.borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: [.selected, .disabled])
        itemScheme.alpha.set(parameter: 0.5, for: [.selected, .disabled])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        
        itemScheme.alpha.set(parameter: 0.5, for: .disabled)
    }
    
}
