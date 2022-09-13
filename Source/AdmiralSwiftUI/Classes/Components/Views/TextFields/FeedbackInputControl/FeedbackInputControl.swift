//
//  FeedbackInputControl.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 FeedbackInputControl - An object that displays an editable text area for enter sms code.

 You can create a FeedbackInputControl with the zero frame rectangle by specifying the following parameters in init:

 - cursorPosition: Binding<Int> - Current cursor position.
 - itemsCount: Int - Number of items in control (default is 5).
 
 ## Example to create FeedbackInputControl
 # Code
 ```
 FeedbackInputControl(cursorPosition: .constant(2))
```
 */
/// An object that displays an editable text area for enter sms code.
@available(iOS 14.0, *)
public struct FeedbackInputControl: View {
    
    private enum Constants {
        static let animationDuration: Double = 0.1
        static let starImage = Asset.System.Solid.starSolid.image
    }
    
    // MARK: - Private Properties
    
    /// Current cursor position.
    @Binding private var cursorPosition: Int
    
    /// Number of items in control.
    private let itemsCount: Int
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Private Properties
    
    @State private var scheme: FeedbackInputControlScheme? = nil
    @ObservedObject private var schemeProvider: SchemeProvider<FeedbackInputControlScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - cursorPosition: Current cursor position.
    ///   - itemsCount: Number of items in control.
    public init(
        cursorPosition: Binding<Int>,
        itemsCount: Int = 5,
        schemeProvider: SchemeProvider<FeedbackInputControlScheme> = AppThemeSchemeProvider<FeedbackInputControlScheme>()
    ) {
        self._cursorPosition = cursorPosition
        self.itemsCount = itemsCount
        self.schemeProvider = schemeProvider
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        
        return ZStack {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16.0, content: {
                ForEach(1..<itemsCount + 1, id: \.self) { index in
                    Image(uiImage: Constants.starImage)
                        .frame(width: 24.0, height: 24.0)
                        .animation(Animation.linear(duration: Constants.animationDuration))
                        .foregroundColor(
                            cursorPosition >= index ?
                                scheme.selectedColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor :
                                scheme.defaultColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                        .onTapGesture {
                            self.cursorPosition = index
                        }
                }
            }
        )}
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: FeedbackInputControlScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
}

@available(iOS 14.0, *)
struct FeedbackInputControl_Previews: PreviewProvider {

    @State static var text: String = ""

    static var previews: some View {
        FeedbackInputControl(cursorPosition: .constant(2))
            .disabled(false)
    }
}
