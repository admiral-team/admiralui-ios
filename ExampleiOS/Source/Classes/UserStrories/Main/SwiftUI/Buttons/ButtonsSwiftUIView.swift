//
//  ButtonsView.swift
//  ExampleiOS
//
//  Created on 17.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ButtonsSwiftUIView: View {
    
    @State private var isDefaultCheckBoxSelected: Bool = false
    @State private var isEnabledControlsState: Int = 0
    
    @State private var isLoadingBigPrimaryButton: Bool = false
    @State private var isLoadingMediumPrimaryButton: Bool = false
    @State private var isLoadingSmallPrimaryButton: Bool = false
    
    @State private var isLoadingBigSecondaryButton: Bool = false
    @State private var isLoadingMediumSecondaryButton: Bool = false
    @State private var isLoadingSmallSecondaryButton: Bool = false
    
    @State private var isLoadingBigGhostButton: Bool = false
    @State private var isLoadingSmallGhostButton: Bool = false
    
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Buttons") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 16.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Primary")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        TwoTitlePrimaryButton(leftText: "08.06.20 — 14.08.20", rightText: "Выбрать", action: {})
                            .frame(height: LayoutGrid.doubleModule * 3)
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Big Button", action: { isLoadingBigPrimaryButton.toggle() })
                            .buttonStyle(PrimaryButtonStyle(isLoading: $isLoadingBigPrimaryButton, sizeType: .big))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Medium Button", action: { isLoadingMediumPrimaryButton.toggle() })
                            .buttonStyle(PrimaryButtonStyle(isLoading: $isLoadingMediumPrimaryButton, sizeType: .medium))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Small Button", action: { isLoadingSmallPrimaryButton.toggle() })
                            .buttonStyle(PrimaryButtonStyle(isLoading: $isLoadingSmallPrimaryButton, sizeType: .small))
                            .disabled(isEnabledControlsState != 0)
                    }
                    Spacer()
                        .frame(height: 56.0)


                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Secondary")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        SwiftUI.Button("Big Button", action: { isLoadingBigSecondaryButton.toggle() })
                            .buttonStyle(SecondaryButtonStyle(isLoading: $isLoadingBigSecondaryButton, sizeType: .big))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Medium Button", action: { isLoadingMediumSecondaryButton.toggle() })
                            .buttonStyle(SecondaryButtonStyle(isLoading: $isLoadingMediumSecondaryButton, sizeType: .medium))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Small Button", action: { isLoadingSmallSecondaryButton.toggle() })
                            .buttonStyle(SecondaryButtonStyle(isLoading: $isLoadingSmallSecondaryButton, sizeType: .small))
                            .disabled(isEnabledControlsState != 0)
                    }

                    Spacer()
                        .frame(height: 56.0)

                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Ghost")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        TwoTitleGhostButton(
                            leftText: "Выбрать все карты",
                            rightText: "Готово",
                            leftAction: {},
                            rightAction: {})
                            .frame(height: LayoutGrid.doubleModule * 3)
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Big Button", action: { isLoadingBigGhostButton.toggle() })
                            .buttonStyle(GhostButtonStyle(isLoading: $isLoadingBigGhostButton, sizeType: .big))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Small Button", action: { isLoadingSmallGhostButton.toggle() })
                            .buttonStyle(GhostButtonStyle(isLoading: $isLoadingSmallGhostButton, sizeType: .small))
                            .disabled(isEnabledControlsState != 0)
                    }
                    
                    Spacer()
                        .frame(height: 32.0)
                    
                    VStack(alignment: .leading, spacing: 32.0) {
                        Text("Rules")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        CheckboxTextbuttonView(
                            title: "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных",
                            isSelected: $isDefaultCheckBoxSelected,
                            subtitleButtonTitle: "Открыть список документов",
                            subtitleButtonAction: {})
                            .disabled(isEnabledControlsState != 0)
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
            .padding()
        }
    }
    
}
