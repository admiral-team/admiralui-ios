//
//  TralingComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 18.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct TralingComponentsSwiftUIView: View {
    
    @State var isRadioButtonListViewControlSelected = true
    @State var isCheckBoxViewControlSelected = true
    @State var isSwitchSelected = true

    @State private var selectedIndex: Int?
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Trailing elements") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    LazyVStack {
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { ArrowListView() },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 0 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 0 ? nil : 0 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { RadioButtonListView(isControlSelected: $isRadioButtonListViewControlSelected) },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 1 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 1 ? nil : 1 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { CheckBoxListView(isControlSelected: $isCheckBoxViewControlSelected) },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 2 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 2 ? nil : 2 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { SwitchListView(isSwitchSelected: $isSwitchSelected) })
                    }
                    LazyVStack {
//                        ListCell(
//                            centerView: { TitleListView(title: "Title") },
//                            trailingView: { IconListView(image: Image(uiImage: Asset.Card.imageCard.image)) },
//                            isSelected:
//                                Binding(
//                                    get: { self.selectedIndex == 4 },
//                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 4 ? nil : 4 }
//                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { CardListView(image: Image(uiImage: Asset.Card.visa.image)) },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 5 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 5 ? nil : 5 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { DatePercentListView(date: "Date", percent: "Text") },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 6 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 6 ? nil : 6 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { ImageWithSubtitleListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Tabs.mirLogo.image)) },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 7 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 7 ? nil : 7 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { SubtitleWithImageListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Tabs.mirLogo.image)) },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 8 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 8 ? nil : 8 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { BadgeArrowListView(badgeStyle: .default, text: "99+") },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 9 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 9 ? nil : 9 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title") },
                            trailingView: { SubtitleImageArrowListView(subtitle: "19.01.2010", image: Image(uiImage: Asset.Tabs.mirLogo.image)) },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 10 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 10 ? nil : 10 }
                                ))
                        ListCell(
                            centerView: { TitleListView(title: "Title").fixedSize() },
                            trailingView: { TagControl(
                                title: "Text text text text text",
                                tagStyle: .default,
                                tapTagControl: {})
                            },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 11 },
                                    set: { _, _ in self.selectedIndex = self.selectedIndex == 11 ? nil : 11 }
                                ),
                            centerLayoutPriority: 0.0,
                            trailingLayoutPriority: 1.0)
                    }
                }
                .disabled(isEnabledControlsState != 0)
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
