//
//  InputNumberButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct InputNumberButtonStyle: ButtonStyle {
    
    @Binding var isPressing: Bool
    
    var backgroundColor = ControlParameter<AColor>()
    var tintColor = ControlParameter<AColor>()
    var image: Image
    var onTap: () -> ()
    
    init(
        isPressing: Binding<Bool>,
        backgroundColor: ControlParameter<AColor>,
        tintColor: ControlParameter<AColor>,
        image: Image,
        onTap: @escaping () -> ()) {
        self._isPressing = isPressing
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.image = image
        self.onTap = onTap
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        InputNumberButton(
            configuration: configuration,
            backgroundColor: backgroundColor,
            tintColor: tintColor,
            image: image,
            onTap: onTap,
            isPressing: $isPressing)
    }
}

@available(iOS 14.0.0, *)
private extension InputNumberButtonStyle {
    struct InputNumberButton: View {
        
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        let backgroundColor: ControlParameter<AColor>
        let tintColor: ControlParameter<AColor>
        let image: Image
        let onTap: () -> ()
        
        @Binding var isPressing: Bool
        
        var body: some View {
            let tintNormal = tintColor.parameter(for: .normal)?.swiftUIColor
            let tintDisabled = tintColor.parameter(for: .disabled)?.swiftUIColor
            let tint = isEnabled ? tintNormal : tintDisabled
            
            let backgroundNormal = backgroundColor.parameter(for: .normal)?.swiftUIColor
            let bacroundDisabled = backgroundColor.parameter(for: .disabled)?.swiftUIColor
            let backgroundHighlighted = backgroundColor.parameter(for: .highlighted)?.swiftUIColor
            let background = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : bacroundDisabled
                        
            image
                .foregroundColor(tint)
                .frame(width: 40.0)
                .frame(height: 40.0)
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                            .foregroundColor(background)
                )
                .onTapGesture {
                    onTap()
                }
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                    self.isPressing = pressing
                }, perform: {})

        }
    }
}
