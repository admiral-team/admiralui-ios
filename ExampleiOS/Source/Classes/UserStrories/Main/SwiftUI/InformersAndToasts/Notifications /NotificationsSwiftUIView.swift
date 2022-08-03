//
//  NotificationsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct NotificationsSwiftUIView: View {
 
    @State private var selection: Int?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Informers & Notifications") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(NotificationsSwiftUIItem.allCases, id: \.self) { item in
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
    func view(for type: NotificationsSwiftUIItem) -> some View {
        switch type {
        case .toast:
            ToastNotificationsSwiftUIView()
        case .static:
            StaticNotificationsSwiftUIView()
        case .action:
            ActionNotificationSwiftUIView()
        }
    }
    
}
