//
//  TextBaseCellSwiftUIView.swift
//  ExampleiOS
//
//  Created on 29.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct TextBaseCellSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Text Cells") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: [
                    StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")
                ],
                            selection: $isEnabledControlsState)
                    .padding(LayoutGrid.doubleModule)
                LazyVStack(alignment: .leading) {
                    Text("Text Cell")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                        .padding(LayoutGrid.doubleModule)
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule)
                    ListCell(
                        // swiftlint:disable line_length
                        centerView: { TitleListView(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.") })
                        .disabled(isEnabledControlsState != 0)
                    Spacer()
                        .frame(height: 36.0)
                    Text("Text Cell vs Icon")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                        .padding(LayoutGrid.doubleModule)
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule)
                    ListCell(
                        // swiftlint:disable line_length
                        centerView: { TitleListView(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.") },
                        trailingView: { IconListView(image: Image(uiImage: Asset.Card.info.image), renderingMode: .original) })
                        .disabled(isEnabledControlsState != 0)
                }
            }
        }
    }
    
}
