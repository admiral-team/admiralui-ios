//
//  CheckControl.swift
//  AdmiralSwiftUI
//
//  Created on 13.04.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 CheckBox - A type of button that lets the user choose between two opposite states, actions, or values. A selected checkbox is considered on when it contains a checkmark and off when it's empty.
 
 You can create a CheckBox by specifying the following parameters in the initializer:
 ## Initializer parameters:
 - text - value of String. Your text will be shown to the right of checkbox
 - isSelected - Binding<Bool>. Observable property for displaying the selected checkbox
 - checkState - CheckControlState. This parameter is responsible for the display style checkbox. Can be in two states: normal, error. Default state is a normal.
 ## Example to create CheckBox:
 # Code
 ```
 CheckBox(
        isSelected: .constant(true),
        text: "Your name of checkbox")
 
 ```
*/
@available(iOS 14.0, *)
public struct CheckBox: View {

    // MARK: - Constants

    private enum Constants {
        static let size: CGFloat = LayoutGrid.tripleModule
    }

    // MARK: - Public Properties
    
    @Binding public var isSelected: Bool
    
    @State public var text: String = ""
    @State public var checkState: CheckControlState = .normal
    
    // MARK: - Private Properties
    
    @Environment(\.isEnabled) private var isEnabled
    
    @State private var scheme: CheckControlScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<CheckControlScheme>()
    
    private var image: Image {
        return isSelected ? Image(uiImage: PrivateAsset.Custom.Control.checkBoxOn.image) : Image(uiImage: PrivateAsset.Custom.Control.checkBoxOff.image)
    }
    
    // MARK: - Initializer
    
    public init(
        isSelected: Binding<Bool>,
        text: String,
        checkState: CheckControlState) {
        self._isSelected = isSelected
        self._text = .init(initialValue: text)
        self._checkState = .init(initialValue: checkState)
    }
    
    public init(
        isSelected: Binding<Bool>,
        text: String) {
        self._isSelected = isSelected
        self._text = .init(initialValue: text)
    }
    
    public init(isSelected: Binding<Bool>) {
        self._isSelected = isSelected
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let tintColor = scheme.tintColor.parameter(for: isEnabled ? .normal : .disabled, state: checkState)
        let textColor = scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)
        HStack {
            image
                .resizable()
                .frame(width: Constants.size, height: Constants.size)
                .foregroundColor(tintColor?.swiftUIColor)
            if !text.isEmpty {
                Text(text)
                    .foregroundColor(textColor?.swiftUIColor)
                    .font(scheme.textFont.swiftUIFont)
            }
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: CheckControlScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
}

