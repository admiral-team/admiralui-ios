//
//  OutlineSliderTabSwiftUITab.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct OutlineSliderTabSwiftUITab: View {

    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
    // MARK: - Private Properties
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isFourItemControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    private let threeControlsoutlineSliderTabItems = [OutlineSliderTabItem(title: "One", badgeStyle: nil, accessibilityId: "ThreeControlsFirst"),
                                                      OutlineSliderTabItem(title: "Two", badgeStyle: nil, accessibilityId: "ThreeControlsSecond"),
                                                      OutlineSliderTabItem(title: "Three", badgeStyle: nil, accessibilityId: "ThreeControlsThird")]

    private let outlineSliderTabNotifications = [OutlineSliderTabItem(title: "One", badgeStyle: .default, accessibilityId: "NotificationsFirst"),
                                                 OutlineSliderTabItem(title: "Two", badgeStyle: .default, accessibilityId: "NotificationsSecond"),
                                                 OutlineSliderTabItem(title: "Three", badgeStyle: .additional, accessibilityId: "NotificationsThird"),
                                                 OutlineSliderTabItem(title: "Four", badgeStyle: nil, accessibilityId: "NotificationsFourth")]
    
    private let sliferControllsTabItems = [OutlineSliderTabItem(title: "One", badgeStyle: nil, accessibilityId: "SliderControlsFirst"),
                                           OutlineSliderTabItem(title: "Two", badgeStyle: nil, accessibilityId: "SliderControlsSecond"),
                                           OutlineSliderTabItem(title: "Three", badgeStyle: nil, accessibilityId: "SliderControlsThird"),
                                           OutlineSliderTabItem(title: "Four", badgeStyle: nil, accessibilityId: "SliderControlsFourth"),
                                           OutlineSliderTabItem(title: "Five", badgeStyle: nil, accessibilityId: "SliderControlsFifth"),
                                           OutlineSliderTabItem(title: "Seven", badgeStyle: nil, accessibilityId: "SliderControlsSeventh"),
                                           OutlineSliderTabItem(title: "Eight", badgeStyle: nil, accessibilityId: "SliderControlsEighth"),
                                           OutlineSliderTabItem(title: "Nine", badgeStyle: nil, accessibilityId: "SliderControlsNineth"),
                                           OutlineSliderTabItem(title: "Ten", badgeStyle: nil, accessibilityId: "SliderControlsTenth"),
                                           OutlineSliderTabItem(title: "Eleven", badgeStyle: nil, accessibilityId: "SliderControlsEleventh")
    ]
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Outline Slider Tabs") {
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
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding()
                        VStack(alignment: .leading) {
                            OutlineSliderTab(
                                items: threeControlsoutlineSliderTabItems,
                                selection: $isTwoItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule)
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("OutlineSliderTabThreeControls")
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
                            OutlineSliderTab(
                                items: sliferControllsTabItems,
                                selection: $isThreeItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule)
                            )
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Notifications")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            OutlineSliderTab(
                                items: outlineSliderTabNotifications,
                                selection: $isFourItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule)
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("OutlineSliderTabNotifications")
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
