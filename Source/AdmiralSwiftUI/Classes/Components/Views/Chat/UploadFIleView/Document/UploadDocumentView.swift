//
//  UploadDocumentView.swift
//  AdmiralUIResources
//
//  Created on 01.11.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI
/**
 UploadDocumentState - Public enum for UploadDocumentView

 UploadDocumentState can be one of the following values:
 - loading
 - description
 - download
 */
@available(iOS 14.0.0, *)
public enum UploadDocumentState {
    case loading
    case description
    case download
}

/**
 UploadDocumentDirection - Public enum for UploadDocumentView

 UploadDocumentDirection can be one of the following values:
 - right
 - left
 */
@available(iOS 14.0.0, *)
public struct UploadDocument: Hashable {

    // MARK: - Public properties

    public var id = UUID().uuidString

    /// Current state of view.
    public var state: UploadDocumentState

    /// File name.
    public let fileName: String

    /// File size.
    public let fileSize: String

    /// Added time.
    public let time: String

    /// Message name creator
    public let name: String?

    /// Image delivery status
    public let status: ChatStatus?

    /// Tap action of close image in loading mode.
    public var closeAction: () -> ()

    // MARK: - Inititializer

    public init(
        state: UploadDocumentState,
        fileName: String,
        fileSize: String,
        time: String,
        name: String? = nil,
        status: ChatStatus? = nil,
        closeAction: @escaping () -> () = {}
    ) {
        self.state = state
        self.fileName = fileName
        self.fileSize = fileSize
        self.time = time
        self.name = name
        self.status = status
        self.closeAction = closeAction
    }

    // MARK: - Public methods

    public func hash(into hasher: inout Hasher) {
        hasher.combine(time)
        hasher.combine(fileName)
        hasher.combine(fileSize)
        hasher.combine(name)
    }

    public static func == (lhs: UploadDocument, rhs: UploadDocument) -> Bool {
        lhs.id == rhs.id
    }

}
/**
 UploadDocumentView - the component that presents a view with loader for uploading and downloading tasks.

 You can create a UploadImageView with the zero frame rectangle by specifying the following parameters in init:

 model: UploadDocument - the model with default settings for view

 cornerStyle: UploadDocumentCornersStyle - corner style of view

 ## Example to create UploadDocumentView
 # Code
 ```
 public var body: some View {
     static let testModel = UploadDocument(
         state: .loading,
         direction: .left,
         fileName: "File.pdf",
         fileSize: "65,6 МБ",
         time: "14:52",
         status: .sent
     )
     UploadDocumentView(model: testModel)
 }
```
 */
@available(iOS 14.0.0, *)
struct UploadDocumentView: View {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = 234
        static let height: CGFloat = 60
        static let cornerRadius: CGFloat = LayoutGrid.doubleModule
        static let spacing: CGFloat = LayoutGrid.doubleModule

        static let paddingHorizontal: CGFloat = LayoutGrid.module + 4
        static let paddingVertical: CGFloat = LayoutGrid.module

        static let circleWidth: CGFloat = LayoutGrid.halfModule * 11
        static let circleHeight: CGFloat = LayoutGrid.halfModule * 11
    }

    // MARK: - Public properties

    /// Initial model with settings for view.
    public let model: UploadDocument

    // MARK: - Private properties

    private var cornersOfGroup: UIRectCorner? = nil
    private var direction: ChatDirection

    @ObservedObject private var schemeProvider: SchemeProvider<UploadDocumentViewScheme>

    // MARK: - Computed properties

    private var roundedCorners: (UIRectCorner, UIRectCorner) {
        if let cornersOfGroup = cornersOfGroup {
            return (cornersOfGroup, cornersOfGroup)
        } else {
            switch direction {
            case .right:
                return ([.bottomRight], [.topRight, .topLeft, .bottomLeft])
            case .left:
                return ([.bottomLeft], [.topRight, .topLeft, .bottomRight])
            }
        }
    }

    // MARK: - Init/deinit

    public init(
        model: UploadDocument,
        cornersOfGroup: UIRectCorner? = nil,
        direction: ChatDirection,
        schemeProvider: SchemeProvider<UploadDocumentViewScheme> = AppThemeSchemeProvider<UploadDocumentViewScheme>()
    ) {
        self.model = model
        self.cornersOfGroup = cornersOfGroup
        self.direction = direction
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        switch direction {
        case .left:
            return HStack(spacing: .zero) {
                if let name = model.name {
                    HStack(spacing: .zero) {
                        Text(name)
                            .font(scheme.messageTextFont.swiftUIFont)
                            .foregroundColor(scheme.messageTextColor.swiftUIColor)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: LayoutGrid.halfModule)
                }
                contentView(scheme: scheme)
            }
            .eraseToAnyView()
        case .right:
            return HStack(spacing: .zero) {
                contentView(scheme: scheme)
            }
            .eraseToAnyView()
        }
    }

    // MARK: - Private methods

    private func contentView(scheme: UploadDocumentViewScheme) -> some View {
        VStack(spacing: -Constants.spacing) {
            HStack(alignment: .top, spacing: Constants.spacing) {
                progressView(scheme: scheme)
                documentDescriptionView(scheme: scheme)
                Spacer()
            }
            timeDescriptionView(scheme: scheme)
        }
        .padding(.horizontal, Constants.paddingHorizontal)
        .padding(.vertical, Constants.paddingVertical)
        .frame(width: Constants.width)
        .background(scheme.backgroundColor.parameter(style: direction)?.swiftUIColor)
        .clipShape(
            RoundedCorner(radius: LayoutGrid.halfModule / 2, corners: roundedCorners.0)
        )
        .clipShape(
            RoundedCorner(radius: LayoutGrid.halfModule * 3, corners: roundedCorners.1)
        )
    }

    private func progressView(scheme: UploadDocumentViewScheme) -> some View {
        return ZStack {
            Circle()
                .fill(scheme.circleColor.parameter(style: direction)?.swiftUIColor ?? Color.blue)
                .frame(width: Constants.circleWidth, height: Constants.circleHeight)
            switch model.state {
            case .loading:
                ProgressView(
                    style: direction == .left ? .default : .accent,
                    closeAction: model.closeAction
                )
            case .description:
                Image(uiImage: ImagesNew.Documents.Outline.descriptionOutline.image)
                    .foregroundColor(scheme.iconColor.parameter(style: direction)?.swiftUIColor)
                    .frame(width: LayoutGrid.tripleModule, height: LayoutGrid.tripleModule)
                    .eraseToAnyView()
            case .download:
                Image(uiImage: ImagesNew.System.Outline.arrowDownOutline.image)
                    .foregroundColor(scheme.iconColor.parameter(style: direction)?.swiftUIColor)
                    .frame(width: LayoutGrid.doubleModule, height: LayoutGrid.doubleModule)
                    .eraseToAnyView()
            }
        }
    }

    private func documentDescriptionView(scheme: UploadDocumentViewScheme) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(model.fileName)
                .foregroundColor(scheme.nameTextColor.parameter(style: direction)?.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
            Text(model.fileSize)
                .foregroundColor(scheme.sizeColor.parameter(style: direction)?.swiftUIColor)
                .font(scheme.sizeTextFont.swiftUIFont)
        }
        .padding(.trailing)
        .padding(.horizontal, .zero)
        .padding(.vertical, LayoutGrid.halfModule)
    }

    private func timeDescriptionView(scheme: UploadDocumentViewScheme) -> some View {
        HStack {
            Spacer()
            ChatBubbleStatusView(
                time: model.time,
                status: model.status,
                direction: direction
            )
        }
    }

}

@available(iOS 14.0, *)
struct UploadDocumentView_Previews: PreviewProvider {

    static let testModel = UploadDocument(
        state: .loading,
        fileName: "File.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static let testModelOne = UploadDocument(
        state: .loading,
        fileName: "File.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .read
    )

    static let testModelTwo = UploadDocument(
        state: .description,
        fileName: "At breakpoint boundaries",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static let testModelThree = UploadDocument(
        state: .download,
        fileName: "At breakpoint boundaries, mini units divide.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .receive
    )

    static var previews: some View {
        VStack {
            UploadDocumentView(model: testModel, direction: .left)
            UploadDocumentView(model: testModelOne, direction: .left)
            UploadDocumentView(model: testModelTwo, direction: .right)
            UploadDocumentView(model: testModelThree, direction: .left)
        }
        .padding()
    }

}
