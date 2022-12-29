//
//  SecondaryButtonsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 15.06.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct SecondaryButtonsSwiftUIView: View {
    
    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
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
        NavigationContentView(navigationTitle: "Secondary Buttons") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"],
                            selection: $isEnabledControlsState,
                            tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                    .accessibility(identifier: "SegmentControl")
                Spacer()
                    .frame(height: 44.0)
                VStack(alignment: .leading, spacing: 16.0) {
                    createBigButton()
                    createMediumButton()
                    createSmallButton()
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
    private func createBigButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Big Button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(SecondaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("BigButtonLeftID")
            createButton(name: "Big Button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("BigButtonRightID")
            SwiftUI.Button("Big Button", action: {})
                .buttonStyle(SecondaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("BigButtonNoneID")
        }
    }
    
    private func createMediumButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Medium Button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(SecondaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("MediumButtonLeftID")
            createButton(name: "Medium Button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("MediumButtonRightID")
            SwiftUI.Button("Medium Button", action: {})
                .buttonStyle(SecondaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("MediumButtonNoneID")
        }
    }
    
    private func createSmallButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Small Button", image: AdmiralUIResources.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(SecondaryButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("SmallButtonLeftID")
            createButton(name: "Small Button", image: AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("SmallButtonRightID")
            SwiftUI.Button("Small Button", action: {})
                .buttonStyle(SecondaryButtonStyle(sizeType: .small))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("SmallButtonNoneID")
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
