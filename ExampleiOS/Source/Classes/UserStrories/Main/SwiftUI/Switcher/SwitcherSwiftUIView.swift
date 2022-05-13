//
//  SwitcherSwiftUIView.swift
//  ExampleiOS
//
//  Created on 19.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SwitcherSwiftUIView: View {

    @StateObject private var viewModel = SwitcherSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            VStack(alignment: .leading) {
                HStack {
                  Spacer()
                }
                StandardTab(items: viewModel.tabItems, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: 54.0)
                VStack(spacing: 48.0) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 16.0) {
                            Text(viewModel.items[index].text)
                                .font(scheme.textFont.swiftUIFont)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                            CustomSwitch(isOn: Binding<Bool>(
                                get: { viewModel.items[index].isEnabled },
                                set: { _ in
                                    viewModel.items[index].isEnabled.toggle()
                                }
                            ))
                            .disabled(viewModel.isEnabledControlsState != 0)
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
}
