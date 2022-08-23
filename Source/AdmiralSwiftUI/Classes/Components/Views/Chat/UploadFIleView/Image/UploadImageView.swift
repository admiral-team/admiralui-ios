//
//  UploadImageView.swift
//  ExampleiOS
//
//  Created on 27.10.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 UploadImageViewCornerStyle - Public enum for UploadImageView

 UploadImageViewCornerStyle can be one of the following values:
 - leftSide
 - rightSide
 - bottom
 - top
 - allSides
 - bottomLeft
 - bottomRight
 - topRight
 - topLeft
 - none
 */
/// Corners style for view
@available(iOS 14.0.0, *)
public enum UploadImageViewCornerStyle: Equatable {
    case leftSide
    case rightSide
    case bottom
    case top
    case allSides
    case bottomLeft
    case bottomRight
    case topRight
    case topLeft
    case none
}

@available(iOS 14.0.0, *)
public struct UploadImageModel: Identifiable {

    // MARK: - Public properties

    public var id = UUID().uuidString

    /// Loading flag.
    public var isLoading: Bool

    /// Add time.
    public let time: String

    /// Background Image.
    public let backgroundImage: Image?

    /// Image  delivery status.
    public var uploadStatus: ChatStatus

    /// Tap action of close image in loading mode.
    public var closeAction: () -> ()

    // MARK: - Init/deinit

    public init(
        isLoading: Bool = false,
        time: String,
        backgroundImage: Image?,
        uploadStatus: ChatStatus,
        closeAction: @escaping () -> () = {}
    ) {
        self.isLoading = isLoading
        self.time = time
        self.backgroundImage = backgroundImage
        self.uploadStatus = uploadStatus
        self.closeAction = closeAction
    }

}

/**
 UploadImageView - the component that presents backgound image with loader for uploading and downloading tasks.

 You can create a UploadImageView with the zero frame rectangle by specifying the following parameters in init:

 - model - Model with parameters to build view.
 - cornersStyle - Parameter that used to set up corner style of view.

 ## Example to create UploadImageView
 # Code
 ```
 public var body: some View {
    let testModel = UploadImageModel(
        isLoading: .constant(true),
        time: "14:52",
        backgroundImage: nil,
        uploadStatus: .read
    )
     UploadImageView(
         model: testModel,
         cornersStyle: .rightSide
     )
 }
```
 */
/// The view that presents backgound image with loader for uploading and downloading process.
@available(iOS 14.0.0, *)
struct UploadImageView: View {

    private enum Constants {
        // MARK: - Common constants

        static let width: CGFloat = 232
        static let height: CGFloat = 114

        static let cornerRadius: CGFloat = LayoutGrid.module + 4.0

        static let lineLimitText = 1

        static let bottomInfoViewPaddingHorizontal: CGFloat = LayoutGrid.module + 4.0
        static let bottomInfoViewPaddingVertical: CGFloat = LayoutGrid.module / 2

        static let blurRadius: CGFloat = 3

        static let opacity: CGFloat = 0.4

        // MARK: - BottomInfoView constants

        static let imageAndTextSpacing: CGFloat = 7.5

        static let checkClearOutlineImageWidth: CGFloat = 9
        static let checkClearOutlineImageHeight: CGFloat = 6.5

        static let bottomViewPadding: CGFloat = LayoutGrid.module / 4
        static let bottomViewTrailing: CGFloat = LayoutGrid.module - 2
        static let bottomViewLeading: CGFloat = LayoutGrid.module / 2
    }

    // MARK: - Public properties

    public let model: UploadImageModel

    // MARK: - Private properties

    private let cornersStyle: UploadImageViewCornerStyle
    private let direction: ChatDirection

    @Binding private var scheme: UploadImageViewScheme?
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<UploadImageViewScheme>()

    // MARK: - Initializer

    public init(
        model: UploadImageModel,
        direction: ChatDirection,
        cornersStyle: UploadImageViewCornerStyle = .allSides,
        scheme: Binding<UploadImageViewScheme?> = .constant(nil)
    ) {
        self.model = model
        self.direction = direction
        self.cornersStyle = cornersStyle
        self._scheme = scheme
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        contentView(scheme: scheme)
            .background(
                model
                    .backgroundImage?
                    .resizable()
                    .scaledToFill()
                    .blur(radius: model.isLoading ? Constants.blurRadius : .zero)
            )
            .modifier(UploadImageViewModifier(cornerStyle: cornersStyle))
    }

    // MARK: - Private methods

    @ViewBuilder private func contentView(scheme: UploadImageViewScheme) -> some View {
        if model.isLoading {
            progressView(scheme: scheme)
        } else {
            bottomView(scheme: scheme)
        }
    }

    private func progressView(scheme: UploadImageViewScheme) -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                ProgressView(
                    style: .staticWhite,
                    progressViewSize: .medium,
                    closeAction: model.closeAction
                )
                Spacer()
            }
            Spacer()
        }
        .background(scheme.loadingMaskColor.swiftUIColor)
    }

    private func bottomView(scheme: UploadImageViewScheme) -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                ChatBubbleStatusView(time: model.time, status: model.uploadStatus, direction: .right, style: .light)
                    .padding(.leading, Constants.bottomViewLeading)
                    .padding(.trailing, Constants.bottomViewTrailing)
                    .padding(.vertical, Constants.bottomViewPadding)
                    .background(scheme.loadingMaskColor.swiftUIColor.zIndex(0))
                    .clipShape(RoundedCorner(radius: Constants.cornerRadius, corners: [.allCorners]))
                    .font(scheme.textFont.swiftUIFont)
                    .foregroundColor(Color.white)
            }
        }
        .padding(.horizontal, LayoutGrid.module + LayoutGrid.halfModule)
        .padding(.vertical, LayoutGrid.module)
    }

    // MARK: - Internal methods

    func scheme(_ scheme: Binding<UploadImageViewScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }

}

@available(iOS 14.0, *)
struct UploadImageView_Previews: PreviewProvider {

    static var previews: some View {
        let testModel = UploadImageModel(
            isLoading: true,
            time: "14:52",
            backgroundImage: nil,
            uploadStatus: .read)
        UploadImageView(
            model: testModel,
            direction: .right,
            cornersStyle: .allSides
        )
        UploadImageView(
            model: testModel,
            direction: .right,
            cornersStyle: .leftSide
        )
    }

}
