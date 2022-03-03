//
//  TabsSwiftUIRow.swift
//  ExampleiOS
//
//  Created by ADyatkov on 20.04.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
struct TabsSwiftUIRow: View {
    @EnvironmentObject private var theme: TabsSwiftUIRowObservable
    
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(theme.titleFont.swiftUIFont)
                .foregroundColor(theme.titleColor.swiftUIColor)
            Spacer()
        }
    }
}
