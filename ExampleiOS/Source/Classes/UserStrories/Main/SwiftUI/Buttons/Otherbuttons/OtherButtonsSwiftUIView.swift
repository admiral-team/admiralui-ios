//
//  OtherButtonsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 05.07.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct OtherButtonsSwiftUIView: View {

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
        NavigationContentView(navigationTitle: "Other buttons") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"],
                            selection: $isEnabledControlsState)
                    .accessibility(identifier: "SegmentControl")
                Spacer()
                    .frame(height: 44.0)
                
                VStack(alignment: .leading, spacing: 16.0) {
                    createButton(name: "Добавить в Apple Wallet",
                                 image: Asset.Card.appleWallet.image,
                                 direction: .left)
                        .buttonStyle(PlatformButtonStyle())
                        .disabled(isEnabledControlsState != 0)
                        .accessibilityIdentifier("AppleWalletButtonID")
                }
                
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
            .padding()
        }
    }

    private func createButton(name: String, image: UIImage?, direction: ImageDirection) -> some View {
        SwiftUI.Button {
        } label: {
            switch direction {
            case .left:
                HStack() {
                    if let image = image {
                        Image(uiImage: image)
                    }

                    Text(name)
                }
            case .right:
                HStack() {
                    Text(name)

                    if let image = image {
                        Image(uiImage: image)
                    }
                }
            }
        }
    }
}
