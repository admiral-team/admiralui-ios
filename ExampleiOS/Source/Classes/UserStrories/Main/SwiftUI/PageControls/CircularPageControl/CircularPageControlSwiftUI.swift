//
//  CircularPageControlSwiftUI.swift
//  ExampleiOS
//
//  Created on 30.12.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct CircularPageCOntrolSwiftUI: View {

    // MARK: - Private Properties

    @State private var isEnabledControlsState: Int = 0
    @State private var totalPages: Int = 0
    @State var step: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Circular Page Control") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading, spacing: LayoutGrid.tripleModule * 3) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        VStack(alignment: .leading) {
                            OutlineSliderTab(
                                items: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"],
                                selection: $totalPages,
                                offset: .constant(LayoutGrid.doubleModule),
                                onTapAction: {
                                    step = 0
                                }
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        SwiftUI.Button(action: {}, label: {})
                            .buttonStyle(
                                CirclePageControlStyle(
                                    step: $step,
                                    totalPages: totalPages + 1,
                                    style: .default
                                )
                            )
                            .accessibility(identifier: "NextCircularPageControll")
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }

}
