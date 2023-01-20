//
//  UnderlineCenterTabsUIView.swift
//  ExampleiOS
//
//  Created on 23.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct UnderlineCenterTabSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isFourItemControlsState: Int = 0
    @State private var isFiveItemControlsState: Int = 0
    @State private var isNotificationsControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    private let twoControllsTabItems = [UnderlineTabItem(title: "One", badgeStyle: nil, accessibilityId: "TwoControlsFirst"),
                                        UnderlineTabItem(title: "Two", badgeStyle: nil, accessibilityId: "TwoControlsSecond")]
    
    private let threeControllsTabItems = [UnderlineTabItem(title: "One", badgeStyle: nil, accessibilityId: "ThreeControlsFirst"),
                                          UnderlineTabItem(title: "Two", badgeStyle: nil, accessibilityId: "ThreeControlsSecond"),
                                          UnderlineTabItem(title: "Three", badgeStyle: nil, accessibilityId: "ThreeControlsThird")]
    
    private let fourControllsTabItems = [UnderlineTabItem(title: "One", badgeStyle: nil, accessibilityId: "FourControlsFirst"),
                                         UnderlineTabItem(title: "Two", badgeStyle: nil, accessibilityId: "FourControlsSecond"),
                                         UnderlineTabItem(title: "Three", badgeStyle: nil, accessibilityId: "FourControlsThird"),
                                         UnderlineTabItem(title: "Four", badgeStyle: nil, accessibilityId: "FourControlsFourth")]
    
    private let fiveControllsTabItems = [UnderlineTabItem(title: "One", badgeStyle: nil, accessibilityId: "FiveControlsFirst"),
                                         UnderlineTabItem(title: "Two", badgeStyle: nil, accessibilityId: "FiveControlsSecond"),
                                         UnderlineTabItem(title: "Three", badgeStyle: nil, accessibilityId: "FiveControlsThird"),
                                         UnderlineTabItem(title: "Four", badgeStyle: nil, accessibilityId: "FiveControlsFourth"),
                                         UnderlineTabItem(title: "Five", badgeStyle: nil, accessibilityId: "FiveControlsFifth")]
    
    private let notificationTabItems = [UnderlineTabItem(title: "One", badgeStyle: .default, accessibilityId: "NotificationsFirst"),
                                        UnderlineTabItem(title: "Two", badgeStyle: .default, accessibilityId: "NotificationsSecond"),
                                        UnderlineTabItem(title: "Three", badgeStyle: .additional, accessibilityId: "NotificationsThird")]
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Underline Center Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                            selection: $isEnabledControlsState)
                    .padding()
                Spacer()
                    .frame(height: 16.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Two controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: twoControllsTabItems,
                                selection: $isTwoItemControlsState,
                                offset: .constant(16.0),
                                isStaticTabs: .constant(true)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Three controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: threeControllsTabItems,
                                selection: $isThreeItemControlsState,
                                offset: .constant(16.0),
                                isStaticTabs: .constant(true)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Four controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: fourControllsTabItems,
                                selection: $isFourItemControlsState,
                                offset: .constant(16.0),
                                isStaticTabs: .constant(true)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                }
                Spacer()
                
                VStack(alignment: .leading, spacing: 16.0) {
                    Text("Five controls")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                        .padding()
                    VStack(alignment: .leading) {
                        UnderlineTab(
                            items: fiveControllsTabItems,
                            selection: $isFiveItemControlsState,
                            offset: .constant(16.0),
                            isStaticTabs: .constant(true)
                        )
                        .disabled(isEnabledControlsState != 0)
                        Spacer()
                    }
                }
                Spacer()
                
                VStack(alignment: .leading, spacing: 16.0) {
                    Text("Notifications")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                        .padding()
                    VStack(alignment: .leading) {
                        UnderlineTab(
                            items: notificationTabItems,
                            selection: $isNotificationsControlsState,
                            offset: .constant(16.0),
                            isStaticTabs: .constant(true)
                        )
                        .disabled(isEnabledControlsState != 0)
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
    
}
