//
//  ParagraphSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ParagraphSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Paragraph") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                
                VStack(spacing: LayoutGrid.quadrupleModule) {
                    HStack(spacing: LayoutGrid.tripleModule) {
                        Text("Primary")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: LayoutGrid.doubleModule) {
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet",
                            paragraphImageType: .point,
                            textAligment: .leading,
                            paragraphStyle: .primary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet",
                            paragraphImageType: .check,
                            textAligment: .leading,
                            paragraphStyle: .primary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                            textAligment: .leading,
                            paragraphStyle: .primary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                            trailingImage: AdmiralUIResources.AssetSymbol.Service.Outline.info.image,
                            textAligment: .leading,
                            paragraphStyle: .primary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                            textAligment: .center,
                            paragraphStyle: .primary)
                    }
                    
                    HStack(spacing: LayoutGrid.quadrupleModule) {
                        Text("Secondary")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: LayoutGrid.doubleModule) {
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet",
                            paragraphImageType: .point,
                            textAligment: .leading,
                            paragraphStyle: .secondary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet",
                            paragraphImageType: .check,
                            textAligment: .leading,
                            paragraphStyle: .secondary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                            textAligment: .leading,
                            paragraphStyle: .secondary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                            trailingImage: AdmiralUIResources.AssetSymbol.Service.Outline.info.image,
                            textAligment: .leading,
                            paragraphStyle: .secondary)
                        
                        ParagraphView(
                            title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                            textAligment: .center,
                            paragraphStyle: .secondary)
                    }
                }
                .disabled(isEnabledControlsState != 0)
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
            
        }
    }
    
}
