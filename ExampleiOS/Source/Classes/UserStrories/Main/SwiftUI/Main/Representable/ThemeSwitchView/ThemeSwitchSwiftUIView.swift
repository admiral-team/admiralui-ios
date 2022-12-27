//
//  ThemeSwitchSwiftUIView.swift
//  ExampleiOS
//
//  Created on 09.07.2021.
//

import AdmiralTheme
import AdmiralSwiftUI
import SwiftUI

@available(iOS 14.0.0, *)
struct ThemeSwitchSwiftUIView: View {
    
    // MARK: - Coordinator

    private let coordinator = ThemeSwitchViewCoordinator()

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ThemeSwitchViewScheme>()
    @State private var isListHidden = true
    @State private var selectedIndex: Int = 0
    @State private var items: [ThemeItem] = []
    
    // MARK: - Layout

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack(spacing: .zero) {
                    if !isListHidden {
                        scrollView(geometry: geometry)
                            .accessibilityElement()
                            .accessibility(addTraits: .isButton)
                            .accessibility(identifier: "ThemeSwitchSwiftUI")
                            .accessibilityValue("Page \(selectedIndex + 1) of \(items.count)")
                            .accessibilityAdjustableAction { direction in
                                switch direction {
                                case .increment:
                                    guard selectedIndex < (items.count - 1) else { break }
                                    selectedIndex += 1
                                    coordinator.didSelect(nil, at: selectedIndex)
                                case .decrement:
                                    guard selectedIndex > 0 else { break }
                                    selectedIndex -= 1
                                    coordinator.didSelect(nil, at: selectedIndex)
                                @unknown default:
                                    break
                                }
                            }
                    }
                    switchButton
                }
            }
            .onAppear {
                items = coordinator.items
                selectedIndex = coordinator.selectedIndex ?? 0
            }
        }
    }

    private var switchButton: some View {
        HStack {
            Spacer()
            SwiftUI.Button("", action: {
                isListHidden.toggle()
            })
            .buttonStyle(ThemeSwitchButtonStyle(isListHidden: $isListHidden))
            .accessibility(identifier: "Ellipse")
        }
        .padding(LayoutGrid.doubleModule)
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func scrollView(geometry: GeometryProxy) -> some View {
        HStack {
            Spacer().frame(width: LayoutGrid.doubleModule)
            HStack {
                Spacer().frame(width: LayoutGrid.doubleModule - 2)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(0..<items.count, id: \.self) { index in
                            themeItemView(index: index)
                        }
                    }
                    .padding(.vertical, LayoutGrid.module)
                    .frame(minWidth: geometry.size.width - ((LayoutGrid.doubleModule * 4) - LayoutGrid.halfModule))
                }
                Spacer().frame(width: LayoutGrid.doubleModule - 2)
            }
            .background(schemeProvider.scheme.backgroundColor.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: LayoutGrid.tripleModule))
            .shadow(
                color: schemeProvider.scheme.shadowColor.swiftUIColor,
                radius: LayoutGrid.module
            )
            Spacer().frame(width: LayoutGrid.doubleModule)
        }
        .accessibility(identifier: "Ellipse")
    }

    @ViewBuilder
    private func themeItemView(index: Int) -> some View {
        let textColor = schemeProvider.scheme.themeTextColor.parameter(for: index == selectedIndex ? .selected : .normal)
        let backgroundColor = schemeProvider.scheme.themeItemBackgroundColor.parameter(for: index == selectedIndex ? .selected : .normal)
        HStack {
            Text(items[index].displayName)
                .font(schemeProvider.scheme.font.swiftUIFont)
                .foregroundColor(textColor?.swiftUIColor)
                .accessibilityElement()
                .accessibility(addTraits: .isButton)
                .accessibility(identifier: items[index].identifier)
                .onTapGesture {
                    selectedIndex = index
                    coordinator.didSelect(nil, at: index)
                }
        }
        .padding(LayoutGrid.module)
        .background(backgroundColor?.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: LayoutGrid.tripleModule))
    }

}
