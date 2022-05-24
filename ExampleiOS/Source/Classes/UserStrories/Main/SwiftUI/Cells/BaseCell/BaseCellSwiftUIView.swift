//
//  BaseCellSwiftUIView.swift
//  ExampleiOS
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct BaseCellSwiftUIView: View {
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Base Cells") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(BaseCellSwiftUIItem.allCases, id: \.self) { item in
                        // WORKAROUND: https://developer.apple.com/forums/thread/677333
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        NavigationLink(destination: view(for: item), tag: item.rawValue, selection: self.$selection) {
                            ListCell(
                                centerView: { TitleListView(title: item.title) },
                                trailingView: { ArrowListView() },
                                isHighlighted: Binding(get: { return self.selection == item.rawValue }, set: { _ in }))
                                .frame(height: 68)
                        }
                        .onTapGesture {
                            withAnimation {
                                self.selection = item.rawValue
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func view(for type: BaseCellSwiftUIItem) -> some View {
        switch type {
        case .center:
            LeadingComponentsSwiftUIView()
        case .leading:
            ImageLableComponentsSwiftUIView()
        case .traling:
            TralingComponentsSwiftUIView()
        }
    }
    
}
