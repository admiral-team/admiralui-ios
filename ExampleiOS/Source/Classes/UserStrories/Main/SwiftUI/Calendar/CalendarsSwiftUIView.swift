//
//  CalendatsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 14.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CalendarsSwiftUIView: View {
    
    @Environment(\.manager) var manager
    
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Calendar") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(CalendarsSwiftUIItem.allCases, id: \.self) { item in
                        // WORKAROUND: FOR NAVIGATION AFTER IOS 14.5
                        // https://developer.apple.com/forums/thread/677333
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
    func view(for type: CalendarsSwiftUIItem) -> some View {
        switch type {
        case .vertical:
            CalendarSwiftUIView()
        case .horizontal:
            CalendarHorizontalSwiftUIView(
                selectedStartDate: nil,
                selectedEndDate: nil)
        }
    }
    
}
