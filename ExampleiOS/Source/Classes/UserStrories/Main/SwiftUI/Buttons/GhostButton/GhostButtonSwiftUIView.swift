//
//  GhostButtonSwiftUIView.swift
//  ExampleiOS
//
//  Created on 15.06.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct GhostButtonSwiftUIView: View {
    
    // MARK: - Image Direction
    
    enum ImageDirection {
        case left
        case right
    }
    
    // MARK: - Internal Properties
    
    @State private var isDefaultCheckBoxSelected: Bool = false
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Ghost Buttons") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 44.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .center, spacing: 16.0) {
                        createBigButton()
                        createMediumButton()
                    }
                    createSmallButton()
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
    private func createBigButton() -> some View {
        VStack(alignment: .center, spacing: 16.0) {
            createButton(name: "Big Button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left
            )
                .buttonStyle(GhostButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
            createButton(name: "Big Button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(GhostButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
            SwiftUI.Button("Big Button", action: {})
                .buttonStyle(GhostButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
        }
    }
    
    private func createMediumButton() -> some View {
        VStack(alignment: .center, spacing: 16.0) {
            createButton(name: "Medium Button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(GhostButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
            createButton(name: "Medium Button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(GhostButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
            SwiftUI.Button("Medium Button", action: {})
                .buttonStyle(GhostButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
        }
    }
    
    private func createSmallButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Small Button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(GhostButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
            createButton(name: "Small Button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(GhostButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
            SwiftUI.Button("Small Button", action: {})
                .buttonStyle(GhostButtonStyle(sizeType: .small))
                .disabled(isEnabledControlsState != 0)
        }
    }
    
    private func createButton(name: String, image: UIImage?, direction: ImageDirection) -> some View {
        return SwiftUI.Button {
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
