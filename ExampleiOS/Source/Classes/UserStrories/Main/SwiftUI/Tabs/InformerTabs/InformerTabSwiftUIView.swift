//
//  InformerTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InformerTabSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Informer Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding(.horizontal, 16.0)
                Spacer()
                    .frame(height: 16.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Two Controls")
                            .padding(.horizontal, 16.0)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        VStack(alignment: .leading) {
                            InformerTab(
                                items: [InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц"),
                                        InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц")],
                                customView: AnyView(InfoSwiftUIView(
                                                        title: .constant("то получу в страховом случае"),
                                                        subtitle: .constant("до 1 500 000 ₽"),
                                                        description: .constant("Выгодный вариант для  двухкомнатной квартиры или дачного дома"
                                                        ))),
                                selection: $isTwoItemControlsState,
                                offsetSegment: .constant(16.0))
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)
                    
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Three Controls")
                            .padding(.horizontal, 16.0)
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            InformerTab(items: [InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц"),
                                                             InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц"),
                                                             InformerSegmentedItem(title: "2 900 ₽", subtitle: "в месяц")],
                                                     customView: AnyView(InfoSwiftUIView(
                                                                            title: .constant("то получу в страховом случае"),
                                                                            subtitle: .constant("до 1 500 000 ₽"),
                                                                            description:
                                                                                .constant("Выгодный вариант для  двухкомнатной квартиры или дачного дома"
                                                                            ))),
                                                     selection: $isThreeItemControlsState,
                                                     offsetSegment: .constant(16.0))
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
