//
//  TwoTitleGhostButton.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import AdmiralTheme
import SwiftUI

/**
 A TwoTitleGhostButton with two text headers (left and right). TwoTitleGhostButton - is used in cases when the main button is not enough, often goes with it in pairs when you need to designate several actions, one of which is the main one.
 You can create a TwoTitleGhostButton by specifying the following parameters in the initializer:
 ## Initializer parameters:
 - leftText - value of String
 - rightText - value of String
 - leftAction - the callback action by tapping left action the button
 - rightAction - the callback action by tapping right action the button
 
 ## Example to create TwoTitleGhostButton:
 # Code
 ```
 TwoTitleGhostButton(
                    leftText: "left Text",
                    rightText: "right Text",
                    leftAction: {},
                    rightAction: {})
 ```
 */
@available(iOS 14.0, *)
public struct TwoTitleGhostButton: View {
    
    // MARK: - Internal Properties
    
    var leftText: String
    var rightText: String
    
    // MARK: - Private Properties
    
    @State private var scheme: TwoTitleGhostButtonScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<TwoTitleGhostButtonScheme>()
    
    private let leftAction: () -> ()
    private let rightAction: () -> ()
    
    // MARK: - Initializer
    
    public init(
        leftText: String,
        rightText: String,
        leftAction: @escaping () -> (),
        rightAction: @escaping () -> ()) {
        self.leftText = leftText
        self.rightText = rightText
        self.leftAction = leftAction
        self.rightAction = rightAction
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        ZStack {
            scheme.backgroundColor.swiftUIColor
            HStack(spacing: LayoutGrid.doubleModule) {
                Button(leftText, action: leftAction)
                    .buttonStyle(GhostButtonStyle())
                Spacer()
                Button(rightText, action: rightAction)
                    .buttonStyle(GhostButtonStyle())
            }
        }

    }
    
    // MARK: - Public Methods
    
    /// Install theme.
    /// - Parameter scheme: Scheme view.
    /// - Returns: view.
    public func scheme(_ scheme: TwoTitleGhostButtonScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
}
