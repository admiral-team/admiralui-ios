//
//  ZeroScreenView.swift
//  AdmiralSwiftUI
//
//  Created on 05.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ZeroScreenView - the component is used to attract the user's attention as a message. A view with title, subtitle and image.

 You can create a ZeroScreenView with the zero frame rectangle by specifying the following parameters in init:

 - image: Image - The image displayed in the image view.
 - title: String - The text that the title label displays.
 - subtitle: String - The text that the subtitle label displays.
 - buttonTitle: String - The text that the button displays.
 - isLoadingButton: Binding<Bool> - For button with an activity indicator

 ## Example to create ZeroScreenView
 # Code
 ```
 public var body: some View {
     ZeroScreenView(
         image: Image("Landscape_4"),
         title: "Title",
         subtitle: "Subtitle",
         buttonTitle: "Ok",
         buttonAction: {})
    }
 }
```
 */
@available(iOS 14.0, *)
public struct ZeroScreenView: View {

    // MARK: - Constants

    private enum Constants {
        static let imageSize = CGFloat(54.0)
    }

    // MARK: - Public Properties

    /// The image displayed in the image view.
    public var image: Image?

    /// The text that the title label displays.
    public var title: String?

    /// The text that the subtitle label displays.
    public var subtitle: String?

    /// The text that the button displays.
    public var buttonTitle: String?

    /// Action button.
    public var buttonAction: () -> ()

    /// Flag loading button.
    @Binding  public var isLoadingButton: Bool

    // MARK: Internal Properties

    @Binding var scheme: ZeroScreenViewScheme?
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ZeroScreenViewScheme>()

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        image: Image? = nil,
        title: String? = nil,
        subtitle: String? = nil,
        buttonTitle: String? = nil,
        isLoadingButton: Binding<Bool> = .constant(false),
        buttonAction: @escaping () -> () = {},
        scheme: Binding<ZeroScreenViewScheme?> = .constant(nil)
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self._isLoadingButton = isLoadingButton
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack(alignment: .center, spacing: 0.0) {
            Spacer()
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: Constants.imageSize,
                        height: Constants.imageSize)
            }
            Spacer()
                .frame(height: LayoutGrid.doubleModule * 2)
            if let title = title {
                Text(title)
                    .font(scheme.titleFont.swiftUIFont)
                    .foregroundColor(scheme.titleColor.swiftUIColor)
                    .frame(height: LayoutGrid.doubleModule * 4)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(scheme.subtitleFont.swiftUIFont)
                    .foregroundColor(scheme.subtitleColor.swiftUIColor)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            if let buttonTitle = buttonTitle {
                Button(buttonTitle, action: buttonAction)
                    .buttonStyle(PrimaryButtonStyle(isLoading: $isLoadingButton))
            }
            Spacer()
                .frame(height: LayoutGrid.doubleModule)
        }
        .padding(.horizontal, LayoutGrid.doubleModule)
    }

    // MARK: - Internal Methods

    func scheme(_ scheme: Binding<ZeroScreenViewScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }

}

@available(iOS 14.0, *)
struct ZeroScreenView_Previews: PreviewProvider {

    static var previews: some View {
        let image = Image(uiImage: PrivateAsset.Custom.Informers.question.image)
        ZeroScreenView(
            image: image,
            title: "Title Center",
            subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            buttonTitle: "Ok",
            buttonAction: {})
    }
}
