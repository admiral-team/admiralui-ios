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
    
    private var twoControlsItems = [LogoTabItem(image: Image(Asset.Tabs.visaLogo.name), accessibilityId: "TwoControlsFirst"),
                                    LogoTabItem(image: Image(Asset.Tabs.masterCardLogo.name), accessibilityId: "TwoControlsSecond")]
    
    private var threeControlsItems = [LogoTabItem(image: Image(Asset.Tabs.visaLogo.name), accessibilityId: "ThreeControlsFirst"),
                                      LogoTabItem(image: Image(Asset.Tabs.masterCardLogo.name), accessibilityId: "ThreeControlsSecond"),
                                      LogoTabItem(image: Image(Asset.Tabs.mirLogo.name), accessibilityId: "ThreeControlsThird")]
    
    private var fourControlsItems = [LogoTabItem(image: Image(Asset.Tabs.visaLogo.name), accessibilityId: "FourControlsFirst"),
                                      LogoTabItem(image: Image(Asset.Tabs.masterCardLogo.name), accessibilityId: "FourControlsSecond"),
                                      LogoTabItem(image: Image(Asset.Tabs.mirLogo.name), accessibilityId: "FourControlsThird"),
                                     LogoTabItem(image: Image(Asset.Card.applePay.name), accessibilityId: "FourControlsFourth")]
    
    private var fiveControlsItems = [LogoTabItem(image: Image(Asset.Tabs.visaLogo.name), accessibilityId: "FiveControlsFirst"),
                                      LogoTabItem(image: Image(Asset.Tabs.masterCardLogo.name), accessibilityId: "FiveControlsSecond"),
                                      LogoTabItem(image: Image(Asset.Tabs.mirLogo.name), accessibilityId: "FiveControlsThird"),
                                     LogoTabItem(image: Image(Asset.Card.applePay.name), accessibilityId: "FiveControlsFourth"),
                                     LogoTabItem(image: Image(Asset.Card.googlePay.name), accessibilityId: "FiveControlsFourth")]
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Logo Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                }
                StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                            selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Two controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        VStack(alignment: .leading) {
                            LogoTab(
                                items: twoControlsItems,
                                selection: $isTwoItemControlsState
                            )
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            LogoTab(
                                items: threeControlsItems,
                                selection: $isThreeItemControlsState
                            )
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Four controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            LogoTab(
                                items: fourControlsItems,
                                selection: $isFourItemControlsState
                            )
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Five controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            LogoTab(
                                items: fiveControlsItems,
                                selection: $isFiveItemControlsState
                            )
                                .disabled(isEnabledControlsState != 0)
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
