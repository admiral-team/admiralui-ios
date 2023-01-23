//
//  CheckBoxSwiftUIView.swift
//  ExampleiOS
//
//  Created on 19.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CheckBoxSwiftUIView: View {

    @State private var isDefaultCheckBoxSelected: Bool = false
    @State private var isDefaultCheckBoxTextSelected: Bool = false
    
    @State private var isSelectedCheckBoxSelected: Bool = true
    @State private var isSelectedCheckBoxTextSelected: Bool = true
    
    @State private var isErrorCheckBoxSelected: Bool = false
    @State private var isErrorCheckBoxTextSelected: Bool = false
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Checkbox") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HStack {
                      Spacer()
                    }
                    StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                        StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                                selection: $isEnabledControlsState)
                    Spacer()
                        .frame(height: 16.0)
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Default")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        CheckBox(isSelected: $isDefaultCheckBoxSelected, text: "", checkState: .normal)
                            .accessibility(identifier: "DefaultCheckBoxFirst")
                            .disabled(isEnabledControlsState != 0)
                        CheckBox(isSelected: $isDefaultCheckBoxTextSelected, text: "Text", checkState: .normal)
                            .accessibility(identifier: "DefaultCheckBoxSecond")
                            .disabled(isEnabledControlsState != 0)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 24.0)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Selected")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        CheckBox(isSelected: $isSelectedCheckBoxSelected, text: "", checkState: .normal)
                            .accessibility(identifier: "SelectedCheckBoxFirst")
                            .disabled(isEnabledControlsState != 0)
                        CheckBox(isSelected: $isSelectedCheckBoxTextSelected, text: "Text", checkState: .normal)
                            .accessibility(identifier: "SelectedCheckBoxSecond")
                            .disabled(isEnabledControlsState != 0)
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 24.0)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Error")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        CheckBox(isSelected: $isErrorCheckBoxSelected, text: "", checkState: .error)
                            .accessibility(identifier: "ErrorCheckBoxFirst")
                            .disabled(isEnabledControlsState != 0)
                        CheckBox(isSelected: $isErrorCheckBoxTextSelected, text: "Text", checkState: .error)
                            .accessibility(identifier: "ErrorCheckBoxSecond")
                            .disabled(isEnabledControlsState != 0)
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
    
}
