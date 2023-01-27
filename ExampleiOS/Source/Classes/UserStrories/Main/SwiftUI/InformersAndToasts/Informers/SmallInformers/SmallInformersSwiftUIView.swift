//
//  SmallInformersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 24.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SmallInformersSwiftUIView: View {
    
    private enum Constants {
        // swiftlint:disable all
        static let description: String = "At breakpoint boundaries, mini units divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights."
        // swiftlint:enable all
        static let titleText: String = "Text Informer"
        static let labelHorizontalPadding: CGFloat = 16.0
    }
    
    // MARK: - Private Properties
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Small Informers") {
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
                        SmallInformerStack {
                            SmallInformer(
                                title: Constants.description,
                                informerStyle: .default,
                                arrowDirection: .topRight
                                )
                                .disabled(isEnabledControlsState != 0)
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Success")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding(.horizontal, Constants.labelHorizontalPadding)
                        SmallInformerStack {
                            SmallInformer(
                                title: Constants.titleText,
                                informerStyle: .success,
                                arrowDirection: .topRight
                                )
                                .disabled(isEnabledControlsState != 0)
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Attention")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding(.horizontal, Constants.labelHorizontalPadding)
                        SmallInformerStack {
                            SmallInformer(
                                title: Constants.titleText,
                                informerStyle: .attention,
                                arrowDirection: .topRight
                            )
                            .disabled(isEnabledControlsState != 0)
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Error")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding(.horizontal, Constants.labelHorizontalPadding)
                        SmallInformerStack {
                            SmallInformer(
                                title: Constants.titleText,
                                informerStyle: .error,
                                arrowDirection: .topRight
                            )
                            .disabled(isEnabledControlsState != 0)
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}

@available(iOS 14.0.0, *)
struct SmallInformerStack<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
//        VStack(alignment: .leading) {
            HStack {
                Spacer().frame(width: 16.0)
                content()
                Spacer()
            }
//        }
    }
}
