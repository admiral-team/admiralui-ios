//
//  StaticNotificationsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct StaticNotificationsSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Static") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    VStack {
                        HStack {
                            Text("Default")
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .info,
                            imageColorType: .info,
                            closeAction: {},
                            type: .default)
                            .disabled(isEnabledControlsState != 0)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .info,
                            imageColorType: .info,
                            closeAction: {},
                            type: .additional)
                            .disabled(isEnabledControlsState != 0)
                    }
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule * 2)
                    
                    VStack {
                        HStack {
                            Text("Success")
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .success,
                            imageColorType: .success,
                            closeAction: {},
                            type: .default)
                            .disabled(isEnabledControlsState != 0)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .success,
                            imageColorType: .success,
                            closeAction: {},
                            type: .success)
                            .disabled(isEnabledControlsState != 0)
                    }
                    
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule * 2)
                    
                    VStack {
                        HStack {
                            Text("Attention")
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .attention,
                            imageColorType: .attention,
                            closeAction: {},
                            type: .default)
                            .disabled(isEnabledControlsState != 0)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .attention,
                            imageColorType: .attention,
                            closeAction: {},
                            type: .attention)
                            .disabled(isEnabledControlsState != 0)
                    }
                    
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule * 2)
                    
                    VStack {
                        HStack {
                            Text("Error")
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            Spacer()
                        }
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .error,
                            imageColorType: .error,
                            closeAction: {},
                            type: .default)
                            .disabled(isEnabledControlsState != 0)
                        ToastView(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            linkAction: {
                            },
                            imageType: .error,
                            imageColorType: .error,
                            closeAction: {},
                            type: .error)
                            .disabled(isEnabledControlsState != 0)
                    }
                    
                }
                .padding(.horizontal, LayoutGrid.doubleModule)
                .padding(.bottom, LayoutGrid.doubleModule * 6)
            }
        }
    }
    
}
