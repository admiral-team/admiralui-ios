//
//  LogoTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 21.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct LogoTabSwiftUIView: View {

    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isFourItemControlsState: Int = 0
    @State private var isFiveItemControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Logo Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                }
                StandardTab(items: ["Default", "Disabled"],
                            selection: $isEnabledControlsState,
                            tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                    .accessibility(identifier: "SegmentControl")
                Spacer()
                    .frame(height: 16.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Two controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        VStack(alignment: .leading) {
                            LogoTab(
                                images: [
                                    Image(Asset.Tabs.visaLogo.name),
                                    Image(Asset.Tabs.masterCardLogo.name)
                                ],
                                selection: $isTwoItemControlsState,
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("LogoTabTwoControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Three controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            LogoTab(
                                images: [
                                    Image(Asset.Tabs.visaLogo.name),
                                    Image(Asset.Tabs.masterCardLogo.name),
                                    Image(Asset.Tabs.mirLogo.name)
                                ],
                                selection: $isThreeItemControlsState,
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("LogoTabThreeControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Four controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            LogoTab(
                                images: [
                                    Image(Asset.Tabs.visaLogo.name),
                                    Image(Asset.Tabs.masterCardLogo.name),
                                    Image(Asset.Tabs.mirLogo.name),
                                    Image(Asset.Card.applePay.name)
                                ],
                                selection: $isFourItemControlsState,
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("LogoTabFourControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Five controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            LogoTab(
                                images: [
                                    Image(Asset.Tabs.visaLogo.name),
                                    Image(Asset.Tabs.masterCardLogo.name),
                                    Image(Asset.Tabs.mirLogo.name),
                                    Image(Asset.Card.applePay.name),
                                    Image(Asset.Card.googlePay.name)
                                ],
                                selection: $isFiveItemControlsState,
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("LogoTabFiveControls")
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
}
