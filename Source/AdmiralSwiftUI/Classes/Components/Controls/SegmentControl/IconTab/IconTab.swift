//
//  IconTab.swift
//  AdmiralUIResources
//
//  Created on 17.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 IconTab - A horizontal control that consists of multiple segments, each segment functioning as a  image with text. The component is used to switch between two or three tabs. It is presented in two versions without additional indentation.

 You can create a IconTab by specifying the following parameters in the initializer
 ## Initializer parameters:
- models - array of IconTabModel. Each element of the array is a tab of Segment Control
- selection - Binding<Int>. Observable property for displaying the selected segment
 ## Example to create LogoTab:
 # Code
 ```
 @State private var isTwoItemControlsState: Int = 0
 IconTab(
     models: [
         IconTabModel(
             image: Image(uiImage: Asset.IconTabs.mobile.image),
             text: "One"
         ),
         IconTabModel(
             image: Image(uiImage: Asset.IconTabs.card.image),
             text: "Two"
         )
     ],
     selection: $isTwoItemControlsState
 )
 ```
*/
@available(iOS 14.0, *)
public struct IconTabModel {

    // MARK: - Properties

    /// The image of IconTabModel
    public let image: Image

    /// The text of IconTabModel
    public let text: String
    
    /// The icon tab accessibility id
    public let accessibilityId: String

    // MARK: - Initializer

    public init(image: Image, text: String, accessibilityId: String = "") {
        self.image = image
        self.text = text
        self.accessibilityId = accessibilityId
    }

}

@available(iOS 14.0, *)
public struct IconTab: View {

    // MARK: - Constants

    private enum Constants {
        static let height: CGFloat = 100
        static let circleSize: CGFloat = LayoutGrid.quadrupleModule + 12
        static let contentSpacing: CGFloat = LayoutGrid.module
        static let contentPadding: CGFloat = LayoutGrid.doubleModule + 4
    }

    // MARK: - Internal methods

    @Environment(\.isEnabled) var isEnabled

    // MARK: - Private properties

    @Binding private var selection: Int
    private var models: [IconTabModel] = []

    @ObservedObject private var schemeProvider: SchemeProvider<IconTabScheme>

    // MARK: - Initializer

    public init(
        models: [IconTabModel],
        selection: Binding<Int>,
        schemeProvider: SchemeProvider<IconTabScheme> = AppThemeSchemeProvider<IconTabScheme>()
    ) {
        self._selection = selection
        self.models = models
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        HStack {
            Spacer()
            ForEach(0..<models.count, id: \.self) { index in
                contentView(index: index, scheme: scheme)
                    .onTapGesture { selection = index }
            }
            Spacer()
        }
        .foregroundColor(scheme.backgroundColor.swiftUIColor)
        .frame(height: Constants.height)
    }

    // MARK: - Private properties

    @ViewBuilder private func contentView(index: Int, scheme: IconTabScheme) -> some View {
        let controlState: ControlState = index == selection ? .selected : .normal
        VStack(spacing: Constants.contentSpacing) {
            ZStack {
                Circle()
                    .foregroundColor(scheme.circleColor.parameter(for: controlState)?.swiftUIColor)
                    .opacity(scheme.alphaColor.parameter(for: isEnabled ? controlState : .disabled) ?? 1.0)
                    .frame(
                        width: Constants.circleSize,
                        height: Constants.circleSize
                    )
                models[index].image
                    .foregroundColor(scheme.iconColor.parameter(for: controlState)?.swiftUIColor)
                    .opacity(scheme.alphaColor.parameter(for: isEnabled ? controlState : .disabled) ?? 1.0)
            }
            Text(models[index].text)
                .foregroundColor(scheme.titleColor.parameter(for: controlState)?.swiftUIColor)
                .opacity(scheme.alphaColor.parameter(for: isEnabled ? controlState : .disabled) ?? 1.0)
                .font(scheme.titleFont.parameter(for: controlState)?.swiftUIFont)
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibility(identifier: models[index].accessibilityId)
        .padding(.horizontal, Constants.contentPadding)
    }

}

@available(iOS 14.0, *)
private struct IconTabPreviewExample: View {

    @State var selection: Int = 0

    var body: some View {
        IconTab(
            models: Array(repeating: IconTabModel(
                image: AssetSymbol.System.Outline.arrowRight.image,
                text: "some text"
            ), count: 3),
            selection: $selection
        )
    }

}

@available(iOS 14.0, *)
struct IconTab_Previews: PreviewProvider {

    static var previews: some View {
        IconTabPreviewExample()
    }

}
