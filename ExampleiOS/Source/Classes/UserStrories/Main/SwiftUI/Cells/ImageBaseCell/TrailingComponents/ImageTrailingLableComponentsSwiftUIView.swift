//
//  ImageTrailingLableComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ImageTrailingLableComponentsSwiftUIView: View {
    
    @State private var isRadioButtonListViewControlSelected = true
    @State private var isCheckBoxViewControlSelected = true
    @State private var isSwitchSelected = true
    @State private var selectedIndex: Int?
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Trailing elements") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 0 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 0 ? nil : 0 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { RadioButtonListView(isControlSelected: $isRadioButtonListViewControlSelected) },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 1 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 1 ? nil : 1 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { CheckBoxListView(isControlSelected: $isCheckBoxViewControlSelected) },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 2 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 2 ? nil : 2 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { SwitchListView(isSwitchSelected: $isSwitchSelected) })
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.rnb.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { IconListView(image: Image(uiImage: Asset.Card.rnb.image)) },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 4 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 4 ? nil : 4 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { CardListView(image: Image(uiImage: Asset.Card.visa.image)) },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 5 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 5 ? nil : 5 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { DatePercentListView(date: "Date", percent: "Text") },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 6 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 6 ? nil : 6 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { ImageWithSubtitleListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Tabs.mirLogo.image)) },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 7 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 7 ? nil : 7 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                    ListCell(
                        leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { SubtitleWithImageListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Tabs.mirLogo.image)) },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 8 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 8 ? nil : 8 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
