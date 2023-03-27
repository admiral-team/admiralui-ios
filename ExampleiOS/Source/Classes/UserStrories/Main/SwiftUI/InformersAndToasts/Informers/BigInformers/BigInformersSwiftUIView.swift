//
//  BigInformersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 18.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct BigInformersSwiftUIView: View {
    
    private enum Constants {
        static let titleText: String = "Headline"
        static let subtitleText: String = "At breakpoint boundaries, mini units divide the screen into a fixed master."
        static let linkText: String = "Link text"
        static let labelHorizontalPadding: CGFloat = 16.0
    }
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Big Informers") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                            selection: $isEnabledControlsState)
                    .padding()
                Spacer()
                    .frame(height: 36.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Default")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding(.horizontal, Constants.labelHorizontalPadding)
                        VStack(alignment: .leading) {
                            BigInformer(
                                title: Constants.titleText,
                                subtitle: Constants.subtitleText,
                                link: Constants.linkText,
                                informerStyle: .default,
                                linkAccessibilityID: "DefaultLinkId",
                                onDetail: {
                                    print("link tapped")
                                })
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Success")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding(.horizontal, Constants.labelHorizontalPadding)
                        VStack(alignment: .leading) {
                            BigInformer(
                                title: Constants.titleText,
                                subtitle: Constants.subtitleText,
                                link: Constants.linkText,
                                informerStyle: .success,
                                linkAccessibilityID: "SuccessLinkId")
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Attention")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding(.horizontal, Constants.labelHorizontalPadding)
                        VStack(alignment: .leading) {
                            BigInformer(
                                title: Constants.titleText,
                                subtitle: Constants.subtitleText,
                                link: Constants.linkText,
                                informerStyle: .attention,
                                linkAccessibilityID: "AttentionLinkId")
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Error")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding(.horizontal, Constants.labelHorizontalPadding)
                        VStack(alignment: .leading) {
                            BigInformer(
                                title: Constants.titleText,
                                subtitle: Constants.subtitleText,
                                link: Constants.linkText,
                                informerStyle: .error,
                                linkAccessibilityID: "ErrorLinkId")
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
