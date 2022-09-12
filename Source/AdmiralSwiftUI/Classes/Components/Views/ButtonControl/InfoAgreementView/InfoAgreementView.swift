//
//  InfoAgreementView.swift
//  AdmiralSwiftUI
//
//  Created on 22.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 InfoAgreementView - The component is used to inform users with the option to select in the checkBox. And also three interaction buttons.
 
 You can create a InfoAgreementView by specifying the following parameters in the initializer:
 
 ## Initializer parameters:
 
 - isSelected: Bool - Flag select checkBox.
 - title: String - The text that the title label displays.
 - subtitleButtonTitle: String? - The text that the subtitle button displays.
 - subtitleButtonAction: () -> () - Action subtitleButton.
 - buttonTitle: String? - The text that the button displays.
 - isLoading: Bool - Flag loading button.
 - buttonAction: () -> () - Action button.
 - additionalButtonTitle: String? - The text that the additionalButtonTitle displays.
 - additionalButtonAction: () -> () - Action additionalButtonAction.
 
 ## Example to create InfoAgreementView
 # Code
 ```
 public var body: some View {
 InfoAgreementView(
     title: "Title",
     isSelected: .constant(true),
     isLoading: .constant(false),
     subtitleButtonTitle: "SubtitleButtonTitle",
     subtitleButtonAction: {},
     buttonTitle: "Action",
     buttonAction: {},
     additionalButtonTitle: "Additional action",
     additionalButtonAction: {})
}
 }
```
 */
@available(iOS 14.0, *)
public struct InfoAgreementView: View {
    
    // MARK: - Public Properties
    
    /// Flag select checkBox.
    @Binding public var isSelected: Bool
    
    /// Flag loading button.
    @Binding public var isLoading: Bool
    
    // MARK: - Private properties
    
    /// The text that the title label displays.
    private var title: String
    
    /// The text that the subtitle button displays.
    private var subtitleButtonTitle: String?
    
    /// Action subtitleButton.
    private var subtitleButtonAction: () -> ()
    
    /// The text that the button displays.
    private var buttonTitle: String?
    
    /// Action button.
    private var buttonAction: () -> ()
    
    /// The text that the additionalButtonTitle displays.
    private var additionalButtonTitle: String?
    
    /// Action additionalButtonAction.
    private var additionalButtonAction: () -> ()
    
    // MARK: Internal Properties
    
    @State var scheme: InfoAgreementViewScheme?
    @ObservedObject var schemeProvider: SchemeProvider<InfoAgreementViewScheme>
    
    private enum Constants {
        // MARK: - Common constants
        static let spacing: CGFloat = LayoutGrid.doubleModule
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init (
        title: String,
        isSelected: Binding<Bool>,
        isLoading: Binding<Bool>,
        subtitleButtonTitle: String? = nil,
        schemeProvider: SchemeProvider<InfoAgreementViewScheme> = AppThemeSchemeProvider<InfoAgreementViewScheme>(),
        subtitleButtonAction: @escaping () -> () = {},
        buttonTitle: String? = nil,
        buttonAction: @escaping () -> () = {},
        additionalButtonTitle: String? = nil,
        additionalButtonAction: @escaping () -> () = {}
    ) {
        self.title = title
        self._isSelected = isSelected
        self._isLoading = isLoading
        self.subtitleButtonTitle = subtitleButtonTitle
        self.subtitleButtonAction = subtitleButtonAction
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.additionalButtonTitle = additionalButtonTitle
        self.additionalButtonAction = additionalButtonAction
        self.schemeProvider = schemeProvider
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 0){
                CheckBox(isSelected: $isSelected)
                Spacer()
                    .frame(width: Constants.spacing)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(scheme.titleFont.swiftUIFont)
                        .foregroundColor(scheme.titleColor.swiftUIColor)
                    if let subtitleButtonTitle = subtitleButtonTitle {
                        Button(subtitleButtonTitle, action: subtitleButtonAction)
                            .buttonStyle(GhostButtonStyle())
                    }
                }
            }
            if let buttonTitle = buttonTitle {
                Button(buttonTitle, action: buttonAction)
                    .buttonStyle(PrimaryButtonStyle(isLoading: $isLoading))
            }
            if let additionalButtonTitle = additionalButtonTitle {
                HStack {
                    Spacer()
                    Button(additionalButtonTitle, action: additionalButtonAction)
                        .buttonStyle(GhostButtonStyle())
                    Spacer()
                }
                
            }
        }
        
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: InfoAgreementViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
}

@available(iOS 14.0, *)
struct InfoAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        InfoAgreementView(
            title: "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных",
            isSelected: .constant(true),
            isLoading: .constant(false),
            subtitleButtonTitle: "Открыть список документов",
            subtitleButtonAction: {},
            buttonTitle: "Действие",
            buttonAction: {},
            additionalButtonTitle: "Альтернативное действие",
            additionalButtonAction: {})
            .padding()
    }
}
