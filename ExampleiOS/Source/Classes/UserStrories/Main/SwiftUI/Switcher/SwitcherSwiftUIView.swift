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
    
    @State private var isCustomSwitchOn: Bool = true
    @State private var isCustomSwitchOff: Bool = false
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Switcher") {
            scheme.backgroundColor.swiftUIColor
            VStack(alignment: .leading) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 54.0)
                HStack {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("On")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        CustomSwitch(isOn: $isCustomSwitchOn)
                            .disabled(isEnabledControlsState != 0)
                    }
                    Spacer()
                }
                Spacer()
                    .frame(height: 48.0)
                
                
                VStack(alignment: .leading, spacing: 16.0) {
                    Text("Off")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    CustomSwitch(isOn: $isCustomSwitchOff)
                        .disabled(isEnabledControlsState != 0)
                }
                Spacer()
            }
            .padding()
        }
    }
    
}
