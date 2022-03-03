//
//  DoubleTextField.swift
//  AdmiralSwiftUI
//
//  Created on 02.06.2021.
//

import SwiftUI
import AdmiralTheme

/**
 DoubleTextField - An object that displays an editable text area for enter sms code.

 You can create a DoubleTextField with the zero frame rectangle by specifying the following parameters in init:

 - state: TextInputState - The state of texfield.
 - info: String - The string that displays some additional info. Default is "".
 - firstTextField: T1 - First Text Field. Object of protocol TextFieldInput.
 - secondTextField: T2 - Second Text Field. Object of protocol TextFieldInput.
 - alignment: Alignment - Alignment textfields. 3 state: Fixed width first textfeild, fixed width second textfield, ratio first to second textfield.
 - infoNumberOfLines: Int? - The maximum number of lines to use for info.
 
 ## Example to create DoubleTextField
 # Code
 ```
 DoubleTextField(
     firstTextField: StandardTextField($text, placeholder: "P1", name: "Optional Label", state: .constant(.normal)),
     secondTextField: StandardTextField($textSecond, placeholder: "P2", name: "Optional Label", state: .constant(.normal)),
     alignment: .ratio(ration: 0.7),
     info: "Info",
     infoNumberOfLines: 1,
     state: .constant(.normal))
```
 */
/// Double text fields with alignment.
@available(iOS 14.0, *)
public struct DoubleTextField<T1, T2>: View where T1: TextFieldInput, T2: TextFieldInput {

    /// Text field alignment.
    public enum Alignment {
        case fixedFirst(first: CGFloat)
        case fixedSecond(second: CGFloat)
        case ratio(ration: CGFloat)
    }
    
    // MARK: - Public Properties
    
    // The state of texfield.
    @Binding  public var state: TextInputState
    
    // The string that displays some additional info.
    public var info: String = ""
    
    // MARK: - Private Properties
    
    /// First Text Field.
    private let firstTextField: T1
    
    /// Second Text Field.
    private let secondTextField: T2
    
    /// Alignment textfields. 3 state: Fixed width first textfeild, fixed width second textfield, ratio first to second textfield.
    public let alignment: Alignment
    
    /// The maximum number of lines to use for info.
    public let infoNumberOfLines: Int?
    
    @State private var scheme: DoubleTextFieldScheme? = nil
    private var accessibilityIdentifier: String?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<DoubleTextFieldScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - firstTextField: First textfield.
    ///   - secondTextField: Second textfield.
    ///   - alignment: Textfields alignment.
    public init(
        firstTextField: T1,
        secondTextField: T2,
        accessibilityIdentifier: String? = nil,
        alignment: Alignment,
        info: String = "",
        infoNumberOfLines: Int? = nil,
        state: Binding<TextInputState> = .constant(.normal)
    ) {
        self.firstTextField = firstTextField
        self.secondTextField = secondTextField
        self.alignment = alignment
        self.info = info
        self.infoNumberOfLines = infoNumberOfLines
        self._state = state
        self.accessibilityIdentifier = accessibilityIdentifier
        self.schemeProvider = AppThemeSchemeProvider<DoubleTextFieldScheme>()
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let isShowInfo = firstTextField.info.isEmpty && secondTextField.info.isEmpty && !info.isEmpty
        var infoColor = scheme.underlineColor.swiftUIColor
        switch state {
        case .error:
            infoColor = scheme.errorColor.swiftUIColor
        case .disabled:
            infoColor = scheme.disabledColor.swiftUIColor
        case .readOnly:
            infoColor = scheme.underlineColor.swiftUIColor
        default:
            break
        }

        return VStack(spacing: 0) {
            switch alignment {
            case .fixedFirst(let firstWidth):
                HStack {
                    firstTextField
                        .state(state)
                        .frame(width: firstWidth)
                    Spacer()
                        .frame(width: LayoutGrid.doubleModule)
                    secondTextField
                        .state(state)
                }
                .padding(.top, LayoutGrid.tripleModule)
                if isShowInfo {
                    textInfoView(infoColor: infoColor, textFont: scheme.informerFont.swiftUIFont)
                        .offset(y: LayoutGrid.tripleModule)
                        .padding(.bottom, LayoutGrid.halfModule * 3)
                }
            case .fixedSecond(let secondWidth):
                HStack {
                    firstTextField
                        .state(state)
                        .frame(width: secondWidth)
                    Spacer()
                        .frame(width: LayoutGrid.doubleModule)
                    secondTextField
                        .state(state)
                }
                .padding(.top, LayoutGrid.tripleModule)
                if isShowInfo {
                    textInfoView(infoColor: infoColor, textFont: scheme.informerFont.swiftUIFont)
                        .offset(y: LayoutGrid.tripleModule)
                        .padding(.bottom, LayoutGrid.halfModule * 3)
                }
            case .ratio(let ration):
                GeometryReader { geometry in
                    HStack {
                        firstTextField
                            .state(state)
                            .frame(width: geometry.size.width * ration)
                        Spacer()
                            .frame(width: LayoutGrid.doubleModule)
                        secondTextField
                            .state(state)
                    }
                    .frame(minHeight: geometry.size.height)
                    if isShowInfo {
                        textInfoView(infoColor: infoColor, textFont: scheme.informerFont.swiftUIFont)
                            .offset(y: LayoutGrid.module * 5)
                    }
                }
                .padding(.top, LayoutGrid.module * 5)
                .padding(.bottom, LayoutGrid.module * 6)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func textInfoView(infoColor: Color, textFont: Font) -> some View {
        return Text(info)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(infoNumberOfLines)
            .font(textFont)
            .accessibilityIdentifier(accessibilityIdentifier ?? "")
            .foregroundColor(infoColor)
            .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.info.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
    }
    
}

@available(iOS 14.0, *)
struct DoudleTextField_Previews: PreviewProvider {

    @State static var text: String? = ""
    @State static var textSecond: String? = ""

    static var previews: some View {
        DoubleTextField(
            firstTextField: StandardTextField($text, placeholder: "P1", name: "Optional Label", state: .constant(.normal)),
            secondTextField: StandardTextField($textSecond, placeholder: "P2", name: "Optional Label", state: .constant(.normal)),
            alignment: .ratio(ration: 0.7),
            info: "Info",
            infoNumberOfLines: 1,
            state: .constant(.normal))
            .padding(16.0)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
