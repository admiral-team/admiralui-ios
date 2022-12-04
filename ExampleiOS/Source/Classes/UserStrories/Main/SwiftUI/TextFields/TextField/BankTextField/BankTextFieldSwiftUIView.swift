//
//  BankTextFieldSwiftUIView.swift
//  ExampleiOS
//
//  Created on 25.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct BankTextFieldSwiftUIView: View {
    
    private enum Constants {
        static let maxSymbols = 19
        static let bankCardTextFieldWidth: CGFloat = 295.0
    }
    
    @State private var text: String? = "1111 2222 3333 4444"
    @State private var controlsState: Int = 0
    @State private var state: TextInputState = .normal
    @State private var isResponder = true
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Card Number") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(
                    items: ["Default", "Error", "Disabled"],
                    selection: $controlsState)
                    .onChange(of: controlsState, perform: { value in
                    self.state = TextInputState(rawValue: value) ?? .normal
                })
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                BankCardTextField(
                    value: $text,
                    formatter: BlocFormatter(format: { value in
                        var targetCursorPosition = 0
                        return modifyCreditCardString(text: value ?? "", cursorPosition: &targetCursorPosition)
                    }),
                    state: $state,
                    contentType: .numberPad,
                    placeholder: "1111 2222 3333 4444",
                    info: .constant("Additional text"),
                    isResponder: $isResponder,
                    onCursorPosition: { startIndex, currentIndex, text in
                        guard text.count <= Constants.maxSymbols else { return startIndex }
                        
                        var targetCursorPosition = currentIndex
                        _ = modifyCreditCardString(text: text, cursorPosition: &targetCursorPosition)

                        return targetCursorPosition
                    })
                    .frame(width: Constants.bankCardTextFieldWidth)
                Spacer()
            }
            .onTapGesture { isResponder = false }
            .padding()
        }
    }
    
    private func modifyCreditCardString(text: String, cursorPosition: inout Int) -> String {
        guard text.count <= Constants.maxSymbols else { return self.text ?? "" }
        
        var cardNumberWithoutSpaces = ""
        cardNumberWithoutSpaces = removeNonDigits(
            string: text,
            andPreserveCursorPosition: &cursorPosition)
        
        return self.insertSpacesEveryFourDigitsIntoString(
            string: cardNumberWithoutSpaces,
            andPreserveCursorPosition: &cursorPosition)
    }
    
    private func modifyCreditCardString(creditCardString: String) -> String {
        guard creditCardString.count <= Constants.maxSymbols else { return text ?? "" }
        
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        
        if !arrOfCharacters.isEmpty {
            for i in 0...arrOfCharacters.count - 1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if (i + 1) % 4 == 0 && i + 1 != arrOfCharacters.count {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return String(modifiedCreditCardString.prefix(Constants.maxSymbols))
    }
    
    private func removeNonDigits(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var digitsOnlyString = ""
        let originalCursorPosition = cursorPosition

        for i in stride(from: 0, to: string.count, by: 1) {
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            if characterToAdd >= "0" && characterToAdd <= "9" {
                digitsOnlyString.append(characterToAdd)
            } else if i < originalCursorPosition {
                cursorPosition -= 1
            }
        }

        return digitsOnlyString
    }

    private func insertSpacesEveryFourDigitsIntoString(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var stringWithAddedSpaces = ""
        let cursorPositionInSpacelessString = cursorPosition

        for i in stride(from: 0, to: string.count, by: 1) {
            if i > 0 && (i % 4) == 0 {
                stringWithAddedSpaces.append(" ")
                if i < cursorPositionInSpacelessString {
                    cursorPosition += 1
                }
            }
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            stringWithAddedSpaces.append(characterToAdd)
        }

        return stringWithAddedSpaces
    }
    
}
