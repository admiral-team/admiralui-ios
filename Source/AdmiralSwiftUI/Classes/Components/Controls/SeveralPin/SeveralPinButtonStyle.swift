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
 ## Initializer parameters:
 - value - Binding<String>. Observable property for displaying text inside Pin Button
 ## Example to create :
 # Code
 ```
 static var body: some View {
 Button(
        action: {},
        label: {Text("Button")})
        .buttonStyle(SeveralPinButtonStyle(value: .constant("34")))
 ```
 */
@available(iOS 14.0.0, *)
public struct SeveralPinButtonStyle: ButtonStyle {
    
    // MARK: - Public Properties
    
    @Binding public var value: String
    
    // MARK: - Private Properties
    
    @State private var scheme: SeveralPinButtonScheme? = nil
    @ObservedObject private var schemeProvider: SchemeProvider<SeveralPinButtonScheme>
    
    // MARK: - Initializer
    
    public init(
        value: Binding<String>,
        schemeProvider: SchemeProvider<SeveralPinButtonScheme> = AppThemeSchemeProvider<SeveralPinButtonScheme>()
    ) {
        self._value = value
        self.schemeProvider = schemeProvider
    }
    
    // MARK: - Public Methods
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = scheme ?? schemeProvider.scheme
        SeveralPinButton(value: $value, scheme: scheme, configuration: configuration)
    }
}

@available(iOS 14.0.0, *)
private extension SeveralPinButtonStyle {
    struct SeveralPinButton: View {
        
        enum Constants {
            static let cornerRadius: CGFloat = LayoutGrid.module
        }
        
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        var scheme: SeveralPinButtonScheme
        @Binding var value: String
        
        init(value: Binding<String>, scheme: SeveralPinButtonScheme, configuration: Configuration) {
            self.configuration = configuration
            self._value = value
            self.scheme = scheme
        }
        
        var body: some View {
            Text(value)
                .padding(LayoutGrid.halfModule * CGFloat(value.count))
                .frame(minWidth: LayoutGrid.tripleModule, minHeight: LayoutGrid.tripleModule)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .background(Circle()
                                .fill(scheme.backgroundColor.swiftUIColor)
                                .background(Circle()
                                                .stroke(scheme.borderColor.swiftUIColor, lineWidth: LayoutGrid.halfModule / 2)))
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
