//
//  RadioButtonSwiftUIView.swift
//  ExampleiOS
//
//  Created on 19.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct RadioButtonSwiftUIView: View {
    
    @State private var isDefaultRadioButtonSelected: Bool = false
    @State private var isDefaultRadioButtonTextSelected: Bool = false
    
    @State private var isSelectedRadioButtonSelected: Bool = true
    @State private var isSelectedRadioButtonTextSelected: Bool = true
    
    @State private var isErrorRadioButtonSelected: Bool = false
    @State private var isErrorRadioButtonTextSelected: Bool = false
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Radiobutton") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HStack {
                      Spacer()
                    }
                    StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    Spacer()
                        .frame(height: 16.0)
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Default")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        RadioControl(isSelected: $isDefaultRadioButtonSelected, text: "", checkState: .normal)
                            .disabled(isEnabledControlsState != 0)
                            .onChange(of: isDefaultRadioButtonSelected) { value in
                                if value {
                                    isDefaultRadioButtonTextSelected = false
                                } else if !isDefaultRadioButtonTextSelected {
                                    isDefaultRadioButtonSelected = true
                                }
                            }
                        RadioControl(isSelected: $isDefaultRadioButtonTextSelected, text: "Text", checkState: .normal)
                            .disabled(isEnabledControlsState != 0)
                            .onChange(of: isDefaultRadioButtonTextSelected) { value in
                                if value {
                                    isDefaultRadioButtonSelected = false
                                } else if !isDefaultRadioButtonSelected {
                                    isDefaultRadioButtonTextSelected = true
                                }
                            }
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 24.0)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Selected")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        RadioControl(isSelected: $isSelectedRadioButtonSelected, text: "", checkState: .normal)
                            .disabled(isEnabledControlsState != 0)
                            .onChange(of: isSelectedRadioButtonSelected) { value in
                                if value {
                                    isSelectedRadioButtonTextSelected = false
                                } else if !isSelectedRadioButtonTextSelected {
                                    isSelectedRadioButtonSelected = true
                                }
                            }
                        RadioControl(isSelected: $isSelectedRadioButtonTextSelected, text: "Text", checkState: .normal)
                            .disabled(isEnabledControlsState != 0)
                            .onChange(of: isSelectedRadioButtonTextSelected) { value in
                                if value {
                                    isSelectedRadioButtonSelected = false
                                } else if !isSelectedRadioButtonSelected {
                                    isSelectedRadioButtonTextSelected = true
                                }
                            }
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 24.0)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Error")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        RadioControl(isSelected: $isErrorRadioButtonSelected, text: "", checkState: .error)
                            .disabled(isEnabledControlsState != 0)
                            .onChange(of: isErrorRadioButtonSelected) { value in
                                if value {
                                    isErrorRadioButtonTextSelected = false
                                } else if !isErrorRadioButtonTextSelected {
                                    isErrorRadioButtonSelected = true
                                }
                            }
                        RadioControl(isSelected: $isErrorRadioButtonTextSelected, text: "Text", checkState: .error)
                            .disabled(isEnabledControlsState != 0)
                            .onChange(of: isErrorRadioButtonTextSelected) { value in
                                if value {
                                    isErrorRadioButtonSelected = false
                                } else if !isErrorRadioButtonSelected {
                                    isErrorRadioButtonTextSelected = true
                                }
                            }
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
    
}
