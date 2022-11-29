//
//  ButtonsView.swift
//  ExampleiOS
//
//  Created on 17.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct PrimaryButtonsSwiftUIView: View {
    
    // MARK: - Image Direction
    
    enum ImageDirection {
        case left
        case right
    }
    
    // MARK: - Internal Properties
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Primary buttons") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 44.0)
                VStack(alignment: .leading, spacing: 16.0) {
                    Button(action: {}, label: {})
                        .buttonStyle(
                            TwoTitlePrimaryButtonStyle(
                                leftTitle: "08.06.20 — 14.08.20",
                                rightTitle: "Выбрать"
                        )
                    )
                    .frame(height: LayoutGrid.doubleModule * 3)
                    .disabled(isEnabledControlsState != 0)
                    createBigButton()
                    createMediumButton()
                    createSmallButton()
                }
                
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
            .padding()
        }
    }
    
    private func createBigButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Big button",
                         image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image,
                         direction: .left)
                .buttonStyle(PrimaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
            createButton(name: "Big button",
                         image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image,
                         direction: .right)
                .buttonStyle(PrimaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
            SwiftUI.Button("Big button", action: {})
                .buttonStyle(PrimaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
        }
    }
    
    private func createMediumButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Medium button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(PrimaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
            createButton(name: "Medium button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(PrimaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
            SwiftUI.Button("Medium button", action: {})
                .buttonStyle(PrimaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
        }
    }
    
    private func createSmallButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Small button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(PrimaryButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
            createButton(name: "Small button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(PrimaryButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
            SwiftUI.Button("Small button", action: {})
                .buttonStyle(PrimaryButtonStyle(sizeType: .small))
                .disabled(isEnabledControlsState != 0)
        }
    }
    
    private func createButton(name: String, image: UIImage?, direction: ImageDirection) -> some View {
        SwiftUI.Button {
        } label: {
            switch direction {
            case .left:
                HStack {
                    if let image = image {
                        Image(uiImage: image)
                    }
                    Text(name)
                }
            case .right:
                HStack {
                    Text(name)
                    if let image = image {
                        Image(uiImage: image)
                    }
                }
            }
        }
    }
}
