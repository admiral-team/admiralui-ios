//
//  LinkSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct LinkSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Link") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                ScrollView(showsIndicators: false) {
                    StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    Spacer()
                        .frame(height: 16.0)
                    VStack(spacing: 0.0) {
                        LinkView(
                            buttonTitle: "Подробнее на сайте банка",
                            buttonAction: {})
                            .disabled(isEnabledControlsState != 0)
                    }
                    .padding(.bottom, LayoutGrid.doubleModule * 4)
                }
            }
        }
    }
}
