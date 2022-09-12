//
//  CheckboxTextbuttonView.swift
//  AdmiralSwiftUI
//
//  Created on 26.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 CheckboxTextbuttonView - The component is used to inform users with the option to select in the checkBox. And also one interaction buttons.
 
 You can create a CheckboxTextbuttonView by specifying the following parameters in the initializer:
 
 ## Initializer parameters:
 
 - isSelected: Bool - Flag select checkBox.
 - title: String - The text that the title label displays.
 - subtitleButtonTitle: String? - The text that the subtitle button displays.
 - subtitleButtonAction: () -> () - Action subtitleButton.
 
 ## Example to create CheckboxTextbuttonView
 # Code
 ```
 public var body: some View {
 CheckboxTextbuttonView(
     title: "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных",
     isSelected: .constant(true),
     isLoading: .constant(false),
     subtitleButtonTitle: "Открыть список документов",
     subtitleButtonAction: {})
}
 }
```
 */
@available(iOS 14.0, *)
public struct CheckboxTextbuttonView: View {
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Public Properties
    
    /// Flag select checkBox.
    @Binding public var isSelected: Bool
    
    // MARK: - Private properties
    
    /// The text that the title label displays.
    private var title: String
    
    /// The text that the subtitle button displays.
    private var subtitleButtonTitle: String?
    
    /// Action subtitleButton.
    private var subtitleButtonAction: () -> ()
    
    // MARK: Internal Properties
    
    @State var scheme: CheckboxTextbuttonViewScheme?
    @ObservedObject var schemeProvider: SchemeProvider<CheckboxTextbuttonViewScheme>
    
    private enum Constants {
        // MARK: - Common constants
        static let spacing: CGFloat = LayoutGrid.doubleModule
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init (
        title: String,
        isSelected: Binding<Bool>,
        subtitleButtonTitle: String? = nil,
        schemeProvider: SchemeProvider<CheckboxTextbuttonViewScheme> = AppThemeSchemeProvider<CheckboxTextbuttonViewScheme>(),
        subtitleButtonAction: @escaping () -> () = {}
    ) {
        self.title = title
        self._isSelected = isSelected
        self.subtitleButtonTitle = subtitleButtonTitle
        self.subtitleButtonAction = subtitleButtonAction
        self.schemeProvider = schemeProvider
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let textColor = scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)

        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 0){
                CheckBox(isSelected: $isSelected, text: "", checkState: .normal)
                Spacer()
                    .frame(width: Constants.spacing)
                VStack(alignment: .leading, spacing: Constants.spacing) {
                    Text(title)
                        .font(scheme.titleFont.swiftUIFont)
                        .foregroundColor(textColor?.swiftUIColor)
                        .onTapGesture {
                            isSelected.toggle()
                        }
                    if let subtitleButtonTitle = subtitleButtonTitle {
                        Button(action: subtitleButtonAction, label: {})
                            .buttonStyle(PrimaryLinkControlStyle(text: subtitleButtonTitle, direction: .left, style: .default))
                    }
                }
            }
        }
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: CheckboxTextbuttonViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
}

@available(iOS 14.0, *)
struct CheckboxTextbuttonView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxTextbuttonView(
            title: "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных",
            isSelected: .constant(true),
            subtitleButtonTitle: "Открыть список документов",
            subtitleButtonAction: {})
            .padding()
    }
}
