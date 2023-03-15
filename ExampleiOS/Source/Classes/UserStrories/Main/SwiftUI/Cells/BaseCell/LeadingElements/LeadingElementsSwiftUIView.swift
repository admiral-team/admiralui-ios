//
//  ImageLableComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct LeadingElementsSwiftUIView: View {
    
    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
    @State private var selectedIndex: Int?
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Leading elements") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0.0) {
                StandardTab(items: [
                    StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")
                ],
                            selection: $isEnabledControlsState)
                    .padding()
                ScrollView(showsIndicators: false) {
                    ListCell(
                        leadingView: { LeadingCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Card Place") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 0 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 0 ? nil : 0 }
                            ))
                        .accessibilityElement()
                        .accessibility(identifier: "LeadingCardTitleArrowListCell")
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageListView(image: Image(uiImage: Asset.Card.rnb.image)) },
                        centerView: { TitleListView(title: "Lable Place") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 1 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 1 ? nil : 1 }
                            ))
                        .accessibilityElement()
                        .accessibility(identifier: "FirstImageTitleArrowListCell")
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageNameListView(text: "IN") },
                        centerView: { TitleListView(title: "Icon Name") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 2 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 2 ? nil : 2 }
                            ))
                        .accessibilityElement()
                        .accessibility(identifier: "SecondImageTitleArrowListCell")
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageBackgroundListView(image: Image(uiImage: Asset.Main.gem.image), renderingMode: .template) },
                        centerView: { TitleListView(title: "Icon Place vs Background") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 3 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 3 ? nil : 3 }
                            ))
                        .accessibilityElement()
                        .accessibility(identifier: "ThirdImageTitleArrowListCell")
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageListView(image: Image(uiImage: Asset.Main.gem.image), renderingMode: .template) },
                        centerView: { TitleListView(title: "Icon Place") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 4 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 4 ? nil : 4 }
                            ))
                        .accessibilityElement()
                        .accessibility(identifier: "FourthImageTitleArrowListCell")
                        .disabled(isEnabledControlsState != 0)
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}