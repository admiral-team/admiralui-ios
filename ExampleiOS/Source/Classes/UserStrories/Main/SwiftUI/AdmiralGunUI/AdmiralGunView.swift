//
//  AdmiralGunView.swift
//  ExampleiOS
//
//  Created by Алмазов Иван Александрович on 04.03.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct AdmiralGunView: View {
    
    @ObservedObject var viewModel = AdmiralGunViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "AdmiralGun") {
            scheme.backgroundColor.swiftUIColor
            VStack {
                SearchBar(
                    $viewModel.searchBarText,
                    isResponder: $viewModel.isResponder,
                    placeholder: "Поиск"
                )
                .padding(.leading, LayoutGrid.doubleModule)
                .padding(.trailing, LayoutGrid.doubleModule)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.items, id: \.self) { _ in
                            
                        }
                    }
                    .padding(LayoutGrid.doubleModule)
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule * 4)
                }
            }
        }
    }
}
