//
//  PinButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 The style for creating the Pin Button. Pin Button - tеhe component displays the position of the object on the map, exists in two states: Default and Selected. It is also possible to change the company logo inside the component or install an icon.
 
 You can create a PinButtonStyle by specifying the following parameters in the initializer
 ## Initializer parameters:
 - images - value of Image. The image is used to set the icon of the element
 - isSelected - Binding<Bool>. Observable property for displaying the selected checkbox
 ## Example to create :
 # Code
 ```

 Button(action: {}, label: {})
        .buttonStyle(PinButtonStyle(
        image: "Your image",
        isSelected: .constant(false)))
 ```
 */
@available(iOS 14.0.0, *)
public struct PinButtonStyle: ButtonStyle {
    
    // MARK: - Public Properties
    
    @Binding public var isSelected: Bool
    public let image: Image
    
    // MARK: - Private Properties
    
    @State private var scheme: PinButtonScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<PinButtonScheme>()
    
    // MARK: - Initializer
    
    public init(
        image: Image,
        isSelected: Binding<Bool>) {
        self.image = image
        self._isSelected = isSelected
    }
    
    // MARK: - Public Methods
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = scheme ?? schemeProvider.scheme
        PinButton(image: image, isSelected: $isSelected, scheme: scheme, configuration: configuration)
    }
}

@available(iOS 14.0.0, *)
private extension PinButtonStyle {
    struct PinButton: View {
        
        enum Constants {
            static let cornerRadius: CGFloat = LayoutGrid.module
        }
        
        @Environment(\.isEnabled) private var isEnabled

        let scheme: PinButtonScheme
        let configuration: Configuration
        @State var image: Image
        @Binding var isSelected: Bool
        
        init(
            image: Image,
            isSelected: Binding<Bool>,
            scheme: PinButtonScheme,
            configuration: Configuration) {
            self.configuration = configuration
            self.scheme = scheme
            self._image = .init(initialValue: image)
            self._isSelected = isSelected
        }
        
        var body: some View {
            if isSelected {
                ZStack {
                    RoundedRectangle(cornerRadius: LayoutGrid.halfModule * 9 / 2)
                        .foregroundColor(scheme.selectedbackgroundColor.swiftUIColor)
                        .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: LayoutGrid.halfModule * 6, height: LayoutGrid.halfModule * 6)
                }
                .frame(width: LayoutGrid.halfModule * 9, height: LayoutGrid.halfModule * 9)
            } else {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: LayoutGrid.halfModule * 6, height: LayoutGrid.halfModule * 6)
                    .background(
                        RoundedRectangle(cornerRadius: LayoutGrid.halfModule * 3)
                            .shadow(color: scheme.shadowColor.swiftUIColor, radius: Constants.cornerRadius, x: 0, y: LayoutGrid.halfModule)
                            .foregroundColor(scheme.backgroundColor.swiftUIColor)
                    )
            }
        }
    }
}

@available(iOS 14.0, *)
struct PinButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Button(action: {}, label: {})
            .buttonStyle(PinButtonStyle(image: AssetSymbol.Category.Outline.acuringModern.image, isSelected: .constant(false)))
    }
}

