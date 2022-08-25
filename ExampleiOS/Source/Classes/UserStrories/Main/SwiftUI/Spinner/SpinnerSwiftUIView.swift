//
//  SpinnerSwiftUIView.swift
//  ExampleiOS
//
//  Created on 12.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct SpinnerSwiftUIView: View {

    // MARK: - Private properties

    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Spinner") {
            scheme.backgroundColor.swiftUIColor
            VStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                StandardTab(items: ["Small", "Medium", "Big"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.halfModule)
                HStack {
                    Spacer()
                    ActivityIndicator(
                        style: .contrast,
                        size: ActivityIndicator.Size(rawValue: isEnabledControlsState) ?? .medium
                    )
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }

}
