//
//  LeadingComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSymbols
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CenterElementsSwiftUIView: View {
    
    @State private var selectedIndex: Int?
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Center elements") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: [
                    StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")
                ],
                            selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    ListCell(
                        centerView: { TitleListView(title: "Title") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 0 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 0 ? nil : 0 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                        .accessibilityElement()
                        .accessibility(identifier: "TitleListView")
                    ListCell(
                        centerView: { TitleSubtitleListView(title: "Title", subtitle: "Subtitle") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 1 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 1 ? nil : 1 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                        .accessibilityElement()
                        .accessibility(identifier: "TitleSubtitleListView")
                    ListCell(
                        centerView: { SubtitleTitleListView(title: "Title", subtitle: "Subtitle") },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 2 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 2 ? nil : 2 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                        .accessibilityElement()
                        .accessibility(identifier: "SubtitleTitleListView")
                    ListCell(
                        centerView: { TitleMoreDetailTextMessageListView(
                            title: "Title",
                            more: "More",
                            detaile: "Detail",
                            detaileMore: "More",
                            subtitle: "Subtitle",
                            tagText: "Percent",
                            messageText: "Text message",
                            infoImage: AdmiralSymbols.AssetSymbol.Service.Outline.info.swiftUIImage)
                        },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 3 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 3 ? nil : 3 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                        .accessibilityElement()
                        .accessibility(identifier: "TitleMoreDetailTextMessageListView")
                    ListCell(
                        centerView: { TitleSubtitleButtonListView(
                            title: "Title",
                            tagSubtitle: "Subtitle",
                            tagText: "Percent",
                            subtitle: "Subtitle 2",
                            buttonTitle: "Button",
                            buttonAction: {})
                        },
                        trailingView: { ArrowListView() },
                        isSelected:
                            Binding(
                                get: { self.selectedIndex == 4 },
                                set: { _, _ in self.selectedIndex = self.selectedIndex == 4 ? nil : 4 }
                            ))
                        .disabled(isEnabledControlsState != 0)
                        .accessibilityElement()
                        .accessibility(identifier: "TitleSubtitleButtonListView")
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
