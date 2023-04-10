//
//  HeadersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct HeadersSwiftUIView: View {
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Header") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0.0) {
                    HStack(spacing: LayoutGrid.doubleModule) {
                        Text("Title 1")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: LayoutGrid.doubleModule) {
                        TitleHeader(
                            title: "Title",
                            headerStyle: .title)
                        DropDownHeader(
                            title: "Title",
                            dropDownHeaderType: .down,
                            headerStyle: .title)
                        SubtitleTitleHeader(
                            title: "Title",
                            subtitle: "Subtitle",
                            headerStyle: .title)
                        TitleSubtitleHeader(
                            title: "Title",
                            subtitle: "Subtitle",
                            headerStyle: .title)
                        TitleArrowWithButtonHeader(
                            title: "Title",
                            buttonTitle: "Button",
                            buttonAction: {},
                            dropDownHeaderType: .down,
                            headerStyle: .title,
                            buttonAccesibilityId: "Title1TitleArrowWithButtonHeader")
                        TitleHeader(
                            title: "Title",
                            textAligment: .center,
                            headerStyle: .title)
                    }
                    
                    HStack(spacing: LayoutGrid.doubleModule) {
                        Text("Subtitle 2")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: LayoutGrid.doubleModule) {
                        TitleHeader(
                            title: "Title",
                            headerStyle: .body)
                        DropDownHeader(
                            title: "Title",
                            dropDownHeaderType: .down,
                            headerStyle: .body)
                        SubtitleTitleHeader(
                            title: "Body Title",
                            subtitle: "Subtitle",
                            headerStyle: .body)
                        TitleSubtitleHeader(
                            title: "Title",
                            subtitle: "Subtitle",
                            headerStyle: .body)
                        TitleArrowWithButtonHeader(
                            title: "Title",
                            buttonTitle: "Button",
                            buttonAction: {},
                            dropDownHeaderType: .down,
                            headerStyle: .body,
                            buttonAccesibilityId: "Subtitle2TitleArrowWithButtonHeader")
                        TitleHeader(
                            title: "Title",
                            textAligment: .center,
                            headerStyle: .body)
                    }
                    
                    HStack(spacing: LayoutGrid.doubleModule) {
                        Text("Headline")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: LayoutGrid.doubleModule) {
                        TitleHeader(
                            title: "Title",
                            headerStyle: .headlineSecondary)
                        TitleHeader(
                            title: "Title",
                            headerStyle: .headline)
                        DropDownHeader(
                            title: "Title",
                            dropDownHeaderType: .down,
                            headerStyle: .headline)
                        SubtitleTitleHeader(
                            title: "Headline",
                            subtitle: "Subtitle",
                            headerStyle: .headline)
                        TitleSubtitleHeader(
                            title: "Title",
                            subtitle: "Subtitle",
                            headerStyle: .headline)
                        TitleArrowWithButtonHeader(
                            title: "Title",
                            buttonTitle: "Button",
                            buttonAction: {},
                            dropDownHeaderType: .down,
                            headerStyle: .headline,
                            buttonAccesibilityId: "HeadlineTitleArrowWithButtonHeader")
                        TitleHeader(
                            title: "Title",
                            textAligment: .center,
                            headerStyle: .headline)
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
