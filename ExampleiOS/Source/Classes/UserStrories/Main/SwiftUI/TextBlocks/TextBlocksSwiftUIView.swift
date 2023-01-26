//
//  TextBlocksSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct TextBlocksSwiftUIView: View {
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Text Blocks") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(TextBlocksSwiftUIItem.allCases, id: \.self) { item in
                        // WORKAROUND: https://developer.apple.com/forums/thread/677333
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        NavigationLink(destination: view(for: item), tag: item.rawValue, selection: self.$selection) {
                            ListCell(
                                centerView: { TitleListView(title: item.title) },
                                trailingView: { ArrowListView() },
                                isHighlighted: Binding(get: { self.selection == item.rawValue }, set: { _ in }))
                                .frame(height: 68)
                                .accessibilityElement()
                                .accessibility(addTraits: .isButton)
                                .accessibility(identifier: item.title)
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
    func view(for type: TextBlocksSwiftUIItem) -> some View {
        switch type {
        case .header:
            HeadersSwiftUIView()
        case .dropDown:
            DropDownSwiftUIView()
        case .paragraph:
            ParagraphSwiftUIView()
        case .link:
            LinkSwiftUIView()
        case .separator:
            SeparatorSwiftUIView()
        }
    }
    
}
