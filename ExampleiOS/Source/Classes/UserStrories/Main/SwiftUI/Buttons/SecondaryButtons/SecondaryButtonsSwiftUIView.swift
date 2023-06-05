//
//  SecondaryButtonsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 15.06.2022.
//

import SwiftUI
import AdmiralImages
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SecondaryButtonsSwiftUIView: View {
    
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
        NavigationContentView(navigationTitle: "Secondary buttons") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                            selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 44.0)
                VStack(alignment: .leading, spacing: 16.0) {
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
            createButton(name: "Big button", image: AdmiralImages.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(SecondaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("BigButtonLeftID")
            
            createButton(name: "Big Button", image: AdmiralImages.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("BigButtonRightID")

            createButton(name: "Big button", image: AdmiralImages.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
            
            SwiftUI.Button("Big button", action: {})
                .buttonStyle(SecondaryButtonStyle(sizeType: .big))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("BigButtonNoneID")
        }
    }
    
    private func createMediumButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Medium button", image: AdmiralImages.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(SecondaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("MediumButtonLeftID")
            
            createButton(name: "Medium Button", image: AdmiralImages.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("MediumButtonRightID")

            createButton(name: "Medium button", image: AdmiralImages.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
            
            SwiftUI.Button("Medium button", action: {})
                .buttonStyle(SecondaryButtonStyle(sizeType: .medium))
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("MediumButtonNoneID")
        }
    }
    
    private func createSmallButton() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            createButton(name: "Small button", image: AdmiralImages.Asset.Category.Outline.heartOutline.image, direction: .left)
                .buttonStyle(SecondaryButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("SmallButtonLeftID")
            
            createButton(name: "Small Button", image: AdmiralImages.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
                .accessibilityIdentifier("SmallButtonRightID")

            createButton(name: "Small button", image: AdmiralImages.Asset.Category.Solid.maintenanceSolid.image, direction: .right)
                .buttonStyle(SecondaryButtonStyle(sizeType: .none))
                .frame(width: 164)
                .disabled(isEnabledControlsState != 0)
            
            SwiftUI.Button("Small button", action: {})
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
