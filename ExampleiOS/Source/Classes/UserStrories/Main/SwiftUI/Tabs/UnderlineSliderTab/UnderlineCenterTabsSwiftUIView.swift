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
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    private let notificationTabItems = [UnderlineTabItem(title: "One", badgeStyle: .default),
                                     UnderlineTabItem(title: "Two", badgeStyle: .default),
                                     UnderlineTabItem(title: "Three", badgeStyle: .additional)]
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Underline Center Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
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
                                items: ["One", "Two"],
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
                                items: ["One", "Two", "Three"],
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
                                items: ["One", "Two", "Three", "Four"],
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
                            items: ["One", "Two", "Three", "Four", "Five"],
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
