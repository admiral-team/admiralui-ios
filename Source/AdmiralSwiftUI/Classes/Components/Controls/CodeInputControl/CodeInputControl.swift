//
//  CodeInputControl.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralUIResources
import AdmiralTheme
import SwiftUI
/**
 CodeInputControl - A control of the entered user characters. Used for secure password entry.
 You can create a PrimaryButton by specifying the following parameters in the initializer:
 - text - Binding<String> Observable property for control count input text
 - itemsCount - value of Int. The property is responsible for the possible number of input characters
 - status - this parameter is responsible for the display style CodeInputControl. Can be in three states: normal, success, error. Default state is a normal.
 ## Example to create :
 # Code
 ```
 CodeInputControl(
                text: .constant("1234"),
                itemsCount: 5,
                status: .normal
 )
 ```
 */
/// Code input control.
@available(iOS 14.0, *)
public struct CodeInputControl: View {
    
    /// Status.
    public enum Status: Int {
        /// The normal status
        case normal
        /// The success status
        case success
        /// The error status
        case error
    }
    
    /// Number of items in control.
    @Binding public var itemsCount: Int
    
    /// Input text.
    @Binding public var text: String
    
    /// Current controll status.
    @Binding public var status: Status
    
    // MARK: - Private Properties
    
    private var cursorPosition = 0

    @Binding private var scheme: CodeInputControlScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<CodeInputControlScheme>()
    
    // MARK: - Initializer
    
    public init(
        text: Binding<String>,
        itemsCount: Int = 4,
        status: CodeInputControl.Status = .normal,
        scheme: Binding<CodeInputControlScheme?> = .constant(nil)
    ) {
        self._text = text
        self._scheme = scheme
        self._itemsCount = Binding(get: {
            return itemsCount
        }, set: { _ in })
        self._status = Binding(get: {
            return status
        }, set: { _ in })
        self.cursorPosition = min(text.wrappedValue.count, itemsCount)
    }

    // MARK: - Body
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        var color = scheme.defaultColor.swiftUIColor
        var activeColor = scheme.activeColor.swiftUIColor
        switch status {
        case .normal:
            color = scheme.defaultColor.swiftUIColor
            activeColor = scheme.activeColor.swiftUIColor
        case .success:
            color = scheme.successColor.swiftUIColor
            activeColor = scheme.successColor.swiftUIColor
        case .error:
            color = scheme.errorColor.swiftUIColor
            activeColor = scheme.errorColor.swiftUIColor
        }
        return HStack(alignment: .center, spacing: LayoutGrid.halfModule * 5) {
            ForEach(0..<itemsCount, id: \.self) { index in
                Circle()
                    .fill(index < cursorPosition ? activeColor : color)
                    .frame(width: LayoutGrid.halfModule * 3, height: LayoutGrid.halfModule * 3)
            }
        }
        .animation(.default)
    }

}

@available(iOS 14.0, *)
struct CodeInputControl_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CodeInputControl(text: .constant("1234"), itemsCount: 5, status: .normal)
        }
    }
    
}

