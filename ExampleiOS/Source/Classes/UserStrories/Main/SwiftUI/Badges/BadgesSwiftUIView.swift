//
//  BadgesSwiftUIView.swift
//  ExampleiOS
//
//  Created on 06.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct BadgesSwiftUIView: View {
    
    @State private var additionalBadge: Double = 1
    @State private var naturalBadge: Double = 1
    @State private var defaultBadge: Double = 1
    @State private var successBadge: Double = 1
    @State private var errorBadge: Double = 1
    @State private var attentionBadge: Double = 1
    
    @State private var isEnabledControlsState: Int = 0
    
    @State private var scheme: BadgesSwiftUIViewScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<BadgesSwiftUIViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Badges") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                VStack(alignment: .center, spacing: LayoutGrid.doubleModule, content: {
                    badgeView(text: "Additional", badgeStyle: .additional, value: $additionalBadge)
                    badgeView(text: "Natural", badgeStyle: .natural, value: $naturalBadge)
                    badgeView(text: "Default", badgeStyle: .default, value: $defaultBadge)
                    badgeView(text: "Success", badgeStyle: .success, value: $successBadge)
                    badgeView(text: "Error", badgeStyle: .error, value: $errorBadge)
                    badgeView(text: "Attention", badgeStyle: .attention, value: $attentionBadge)
                    Spacer()
                })
                .disabled(isEnabledControlsState != 0)
            }
            .padding(LayoutGrid.doubleModule)
        }
    }
    
    private func badgeView(text: String, badgeStyle: BadgeStyle, value: Binding<Double>) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return HStack(alignment: .center, spacing: 0.0, content: {
            BadgeView(badgeStyle: badgeStyle,
                      value: Int(value.wrappedValue)) {
                AssetSymbol.Category.Solid.bonus.image
                    .foregroundColor(scheme.imageTintColor.swiftUIColor)
                    .frame(width: LayoutGrid.halfModule * 11, height: LayoutGrid.halfModule * 11)
                    .background(
                        RoundedRectangle(cornerRadius: LayoutGrid.halfModule * 11 / 2)
                            .foregroundColor(scheme.backgroundColor.swiftUIColor)
                    )
            }
            Spacer()
                .frame(width: LayoutGrid.doubleModule)
            Text(text)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            Spacer()
            InputNumber(
                titleText: .constant(nil),
                value: value,
                minimumValue: .constant(0),
                maximumValue: .constant(1000),
                stepValue: .constant(1.0))
        })
        .frame(height: LayoutGrid.doubleModule * 4)
    }
    
}
