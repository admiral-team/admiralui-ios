//
//  TwoTitlePrimaryButton.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import AdmiralTheme
import SwiftUI
/**
 A TwoTitlePrimaryButton with two text headers (left and right). PrimaryButton - the main button for the most important actions

 You can create a TwoTitlePrimaryButton by specifying the following parameters in the initializer
 ## Initializer parameters:
 - leftText - value of String
 - rightText - value of String
 - action - the callback action by tapping the button
 
 ## Example to create TwoTitlePrimaryButton:
 # Code
 ```
 TwoTitlePrimaryButton(
                    leftText: "left Text",
                    rightText: "right Text",
                    action: {}
 )
 ```
 */
@available(iOS 14.0, *)
public struct TwoTitlePrimaryButton: View {
    
    // MARK: - Internal Properties
    
    var leftText: String
    var rightText: String
    
    // MARK: - Private Properties

    private let action: () -> ()

    @ObservedObject private var schemeProvider: SchemeProvider<TwoTitlePrimaryButtonScheme>
    
    // MARK: - Initializer
    
    public init(
        leftText: String,
        rightText: String,
        action: @escaping () -> (),
        schemeProvider: SchemeProvider<TwoTitlePrimaryButtonScheme> = AppThemeSchemeProvider<TwoTitlePrimaryButtonScheme>()
    ) {
        self.leftText = leftText
        self.rightText = rightText
        self.action = action
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        Button("", action: action)
            .buttonStyle(
                TwoTitlePrimaryButtonStyle(
                    leftTitle: leftText,
                    rightTitle: rightText,
                    schemeProvider: schemeProvider
                )
            )
    }
    
}

@available(iOS 14.0, *)
struct Two_Previews: PreviewProvider {
    static var previews: some View {
        Spacer()
        TwoTitlePrimaryButton(leftText: "d", rightText: "d", action: {})
        Spacer()
    }
}

