//
//  BankTextFieldSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class BankTextFieldSwiftUIViewModel: ObservableObject {

    // MARK: - Constants

    private enum Constants {
        static let maxSymbols = 19
        static let bankCardTextFieldWidth: CGFloat = 295.0
    }

    // MARK: - Published Properties

    @Published var text: String? = "1111 2222 3333 4444"
    @Published var controlsState: Int = 0
    @Published var state: TextInputState = .normal
    @Published var isResponder = true

    // MARK: - Internal Properties

    var title: String {
        "Card Number"
    }

    var tabItems: [String] {
        ["Default", "Error", "Disabled"]
    }

}

@available(iOS 14.0.0, *)
extension BankTextFieldSwiftUIViewModel {

    func modifyCreditCardString(text: String, cursorPosition: inout Int) -> String {
        guard text.count <= Constants.maxSymbols else { return self.text ?? "" }

        var cardNumberWithoutSpaces = ""
        cardNumberWithoutSpaces = removeNonDigits(
            string: text,
            andPreserveCursorPosition: &cursorPosition)

        return self.insertSpacesEveryFourDigitsIntoString(
            string: cardNumberWithoutSpaces,
            andPreserveCursorPosition: &cursorPosition)
    }

    func modifyCreditCardString(creditCardString: String) -> String {
        guard creditCardString.count <= Constants.maxSymbols else { return text ?? "" }

        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if arrOfCharacters.count > 0 {
            for i in 0...arrOfCharacters.count - 1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if (i + 1) % 4 == 0 && i + 1 != arrOfCharacters.count {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return String(modifiedCreditCardString.prefix(Constants.maxSymbols))
    }

    func removeNonDigits(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
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

    func insertSpacesEveryFourDigitsIntoString(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
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
