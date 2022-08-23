//
//  SeveralPinStyle.swift
//  AdmiralSwiftUI
//
//  Created on 15.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 The style for creating the Several Pin Button. Several Pin Button - the component displays the position of several objects on the map at one point, exists in three sizes: Small, Medium and Big - use the appropriate one depending on the number of characters.
 You can create a SeveralPinButtonStyle by specifying the following parameters in the initializer
 Initializer parameters:
 - value - Binding<String>. Observable property for displaying text inside Pin Button
 Example to create :
 Code
 ```
var body: some View {
 Button(
    action: {},
    label: {Text("Button")}
 )
.buttonStyle(SeveralPinButtonStyle(value: .constant("34"))
 }
 ```
 */
@available(iOS 14.0.0, *)
public struct SeveralPinButtonStyle: ButtonStyle {
    
    // MARK: - Public Properties
    
    @Binding public var value: String
    
    // MARK: - Private Properties
    
    @Binding private var scheme: SeveralPinButtonScheme?
    
    // MARK: - Initializer
    
    public init(
        value: Binding<String>,
        scheme: Binding<SeveralPinButtonScheme?> = .constant(nil)
    ) {
        self._scheme = scheme
        self._value = value
    }
    
    // MARK: - Public Methods
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SeveralPinButton(
            value: $value,
            scheme: $scheme,
            configuration: configuration
        )
    }
}

@available(iOS 14.0.0, *)
private extension SeveralPinButtonStyle {
    struct SeveralPinButton: View {

        // MARK: - Constants

        enum Constants {
            static let cornerRadius: CGFloat = LayoutGrid.module
        }

        // MARK: - Environment

        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        @Binding var value: String

        // MARK: - Body

        @Binding private var scheme: SeveralPinButtonScheme?
        @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SeveralPinButtonScheme>()

        // MARK: - Initializer

        init(
            value: Binding<String>,
            scheme: Binding<SeveralPinButtonScheme?>,
            configuration: Configuration
        ) {
            self.configuration = configuration
            self._value = value
            self._scheme = scheme
        }

        // MARK: - Body

        var body: some View {
            let scheme = self.scheme ?? schemeProvider.scheme
            Text(value)
                .padding(LayoutGrid.halfModule * CGFloat(value.count))
                .frame(minWidth: LayoutGrid.tripleModule, minHeight: LayoutGrid.tripleModule)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .background(
                    Circle()
                        .fill(scheme.backgroundColor.swiftUIColor)
                        .background(Circle()
                            .stroke(scheme.borderColor.swiftUIColor, lineWidth: LayoutGrid.halfModule / 2)
                        )
                )
        }
    }
}

@available(iOS 14.0, *)
struct Pd_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        }).buttonStyle(SeveralPinButtonStyle(value: .constant("34")))
    }
}
