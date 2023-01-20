//
//  UnderlineSliderTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct UnderlineSliderTabSwiftUIView: View {
    
    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isStaticControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    private let threeControllsTabItems = [UnderlineTabItem(title: "One", badgeStyle: nil, accessibilityId: "ThreeControlsFirst"),
                                          UnderlineTabItem(title: "Two", badgeStyle: nil, accessibilityId: "ThreeControlsSecond"),
                                          UnderlineTabItem(title: "Three", badgeStyle: nil, accessibilityId: "ThreeControlsThird")]
    
    private let sliferControllsTabItems = [UnderlineTabItem(title: "One", badgeStyle: nil, accessibilityId: "SliderControlsFirst"),
                                           UnderlineTabItem(title: "Two", badgeStyle: nil, accessibilityId: "SliderControlsSecond"),
                                           UnderlineTabItem(title: "Three", badgeStyle: nil, accessibilityId: "SliderControlsThird"),
                                           UnderlineTabItem(title: "Four", badgeStyle: nil, accessibilityId: "SliderControlsFourth"),
                                           UnderlineTabItem(title: "Five", badgeStyle: nil, accessibilityId: "SliderControlsFifth"),
                                           UnderlineTabItem(title: "Seven", badgeStyle: nil, accessibilityId: "SliderControlsSeventh"),
                                           UnderlineTabItem(title: "Eight", badgeStyle: nil, accessibilityId: "SliderControlsEighth"),
                                           UnderlineTabItem(title: "Nine", badgeStyle: nil, accessibilityId: "SliderControlsNineth"),
                                           UnderlineTabItem(title: "Ten", badgeStyle: nil, accessibilityId: "SliderControlsTenth"),
                                           UnderlineTabItem(title: "Eleven", badgeStyle: nil, accessibilityId: "SliderControlsEleventh")
    ]
    
    private let notificationsTabItems = [UnderlineTabItem(title: "One", badgeStyle: .default, accessibilityId: "NotificationsFirst"),
                                         UnderlineTabItem(title: "Two", badgeStyle: .default, accessibilityId: "NotificationsSecond"),
                                         UnderlineTabItem(title: "Three", badgeStyle: .additional, accessibilityId: "NotificationsThird"),
                                         UnderlineTabItem(title: "Four", badgeStyle: nil, accessibilityId: "NotificationsFourth")]
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Underline Slider Tabs") {
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
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: threeControllsTabItems,
                                selection: $isTwoItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)

                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Slider controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: sliferControllsTabItems,
                                selection: $isThreeItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)

                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Notifications")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: notificationsTabItems,
                                selection: $isStaticControlsState,
                                offset: .constant(16.0)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
