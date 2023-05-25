//
//  RulesSwiftUIView.swift
//  ExampleiOS
//
//  Created on 15.06.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI


@available(iOS 14.0.0, *)
struct RulesSwiftUIView: View {
    
    // MARK: - Internal Properties

    @State private var isDefaultCheckBoxSelected: Bool = false
    @State private var isEnabledControlsState: Int = 0
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Rules") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                            selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 44.0)
                
                VStack(alignment: .leading, spacing: 32.0) {
                    Text("Rules")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    CheckboxTextbuttonView(
                        title: "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных",
                        isSelected: $isDefaultCheckBoxSelected,
                        subtitleButtonTitle: "Открыть список документов",
                        checkBoxAccessibilityIdentifier: "CheckBoxAccessibilityIdentifier",
                        linkButtonAccessibilityIdentifier: "LinkButtonAccessibilityIdentifier",
                        subtitleButtonAction: {})
                        .disabled(isEnabledControlsState != 0)
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
}
