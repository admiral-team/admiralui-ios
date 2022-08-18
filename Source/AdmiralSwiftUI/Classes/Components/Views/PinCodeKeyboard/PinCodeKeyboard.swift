//
//  PinCodeKeyboard.swift
//  AdmiralSwiftUI
//
//  Created on 04.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 PinCodeButtonType - Public enum for type PinCodeKeyboard
 
 PinCodeButtonType can be one of the following values:
 - rightButton
 - leftButton
 */
enum PinCodeButtonType {
    case rightButton
    case leftButton
}
 
/**
 PinCodeKeyboard - A view for secure pin code entry.

 You can create a PinCodeKeyboard with the zero frame rectangle by specifying the following parameters in init:

 - leftButtonTitle: String - Title for left button
 - rightButtonImage: Image - Image for right button
 - didTapNumber: Handle number tap
 - didTapLeftButton: Handle left button tap
 - didTapRightButton: Handle right button tap

 progressViewSize: ProgressViewSize - the size for progress spinner.

 ## Example to create PinCodeKeyboard
 # Code
 ```
 PinCodeKeyboard(
     leftButtonTitle: "Не могу войти",
     rightButtonImage: Image("Your image"),
     didTapNumber: {},
     didTapLeftButton: {},
     didTapRightButton: {}
 )
```
 */
@available(iOS 14.0, *)
public struct PinCodeKeyboard: View {

    // MARK: - Constants

    private enum Constants {
        static let keyboardInsets: EdgeInsets = EdgeInsets(
            top: 0,
            leading: 25,
            bottom: 12,
            trailing: 25)
        static let keyboardWidth: CGFloat = 270.0
        static let keyboardHeight: CGFloat = 288.0
    }

    // MARK: - Private Properties
    
    private var rightButtonImage: Image
    private var leftButtonTitle: String
    private let didTapNumber: (Int) -> ()
    private let didTapLeftButton: () -> ()
    private let didTapRightButton: () -> ()

    @State private var scheme: PinCodeTextViewScheme? = nil
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<PinCodeTextViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated input number object.
    /// - Parameters:
    ///   - leftButtonTitle: Title for left button
    ///   - rightButtonImage: Image for right button
    ///   - didTapNumber: Handle number tap
    ///   - didTapLeftButton: Handle left button tap
    ///   - didTapRightButton: Handle right button tap
    public init(
        leftButtonTitle: String = "",
        rightButtonImage: Image = AssetSymbol.Security.Outline.faceID.image,
        didTapNumber: @escaping (Int) -> (),
        didTapLeftButton: @escaping () -> (),
        didTapRightButton: @escaping () -> (),
        scheme: PinCodeTextViewScheme? = nil
    ) {
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonImage = rightButtonImage
        self.didTapNumber = didTapNumber
        self.didTapLeftButton = didTapLeftButton
        self.didTapRightButton = didTapRightButton
        self.scheme = scheme
    }


    // MARK: - Body
    
    public var body: some View {
        let numbers: [[Int]] = numbers()
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack(spacing: 16.0) {
            ForEach(numbers, id: \.self) { numberSet in
                createHStack(numbers: numberSet)
            }
            
            HStack(alignment: .center) {
                Button(leftButtonTitle) {
                    didTapLeftButton()
                }
                .buttonStyle(PinCodeTextViewStyle())
                Spacer(minLength: 0.0)
                Button(String(0), action: {
                    didTapNumber(0)
                })
                .buttonStyle(PinCodeNumberViewStyle())
                Spacer(minLength: 44.0)
                Button {
                    didTapRightButton()
                } label: {
                    rightButtonImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44, alignment: .center)
                }
                .buttonStyle(PinCodeTextViewStyle())
            }
        }
        .frame(
            width: Constants.keyboardWidth,
            height: Constants.keyboardHeight,
            alignment: .center)
        .padding(Constants.keyboardInsets)
        .foregroundColor(scheme.backgroundColor.swiftUIColor)
    }
    
    // MARK: - Private Methods
    
    private func createHStack(numbers: [Int]) -> some View {
        HStack(spacing: 44.0) {
            ForEach(numbers, id: \.self) { number in
                Button(String(number), action: {
                    didTapNumber(number)
                })
                .buttonStyle(PinCodeNumberViewStyle())
            }
        }
    }
    
    private func numbers() -> [[Int]] {
        var result = [[Int]]()
        for i in 0...2 {
            var items = [Int]()
            for j in 1...3 {
                let number = j + i * 3
                items.append(number)
            }
            result.append(items)
        }
        return result
    }

}

@available(iOS 14.0, *)
struct PinCodeKeyboard_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            PinCodeKeyboard(
                leftButtonTitle: "Не могу войти",
                rightButtonImage: AssetSymbol.Security.Outline.faceID.image,
                didTapNumber: { index in
                    
                },
                didTapLeftButton: {
                    
                },
                didTapRightButton: {
                    
                }
            )
        }
    }
    
}
