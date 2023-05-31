//
//  UploadDocumentGroupView.swift
//  AdmiralUIResources
//
//  Created on 01.11.2021.
//

import AdmiralTheme
import SwiftUI
/**
 UploadDocumentGrid - the component that presents a view container for UploadDocumentView.

 You can create a UploadDocumentGrid with the zero frame rectangle by specifying the following parameters in init:

 - documentsList: [UploadDocument] - an array with UploadDocument models
 - direction: direction message

 ## Example to create UploadDocumentGrid
 # Code
 ```
 public var body: some View {
     let testModelThree = UploadDocument(
         style: .accent,
         progressStyle: .accent,
         state: .download,
         fileName: "At breakpoint boundaries, mini units divide.pdf",
         fileSize: "65,6 МБ",
         time: "14:52"
     )

     let testModelThree = UploadDocument(
         style: .accent,
         progressStyle: .accent,
         state: .download,
         fileName: "At breakpoint boundaries, mini units divide.pdf",
         fileSize: "65,6 МБ",
         time: "14:52"
     )

    UploadDocumentGrid(documentsList: [testModel, testModelThree], direction: .right)
 }
```
 */
@available(iOS 14.0.0, *)
public struct UploadDocumentGrid: View {

    // MARK: - Public properties

    /// Tapped index of  element.
    public var tappedIndex: ((_ index: Int) -> Void)?
    
    // MARK: Internal Properties

    /// Scheme provider serves for changing scheme while change theme.
    @ObservedObject var schemeProvider: SchemeProvider<UploadDocumentGridScheme>

    // MARK: - Private properties

    /// An array with documentsList models
    private var models: [UploadDocument]

    /// Direction message.
    private let direction: ChatDirection

    /// Action error button.
    private var errorAction: () -> ()

    // MARK: - Initializer

    public init(
        models: [UploadDocument],
        direction: ChatDirection,
        tappedIndex: ((_ index: Int) -> Void)? = nil,
        errorAction: @escaping () -> () = {},
        schemeProvider: SchemeProvider<UploadDocumentGridScheme> = AppThemeSchemeProvider<UploadDocumentGridScheme>()
    ) {
        self.models = models
        self.direction = direction
        self.tappedIndex = tappedIndex
        self.errorAction = errorAction
        self.schemeProvider = schemeProvider
    }

    public init(
        model: UploadDocument,
        direction: ChatDirection,
        tappedIndex: ((_ index: Int) -> Void)? = nil,
        errorAction: @escaping () -> () = {},
        schemeProvider: SchemeProvider<UploadDocumentGridScheme> = AppThemeSchemeProvider<UploadDocumentGridScheme>()
    ) {
        self.models = [model]
        self.direction = direction
        self.tappedIndex = tappedIndex
        self.errorAction = errorAction
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        switch direction {
        case .left:
            HStack(alignment: .bottom, spacing: 0) {
                uploadDocumentView()
                Spacer()
            }.eraseToAnyView()
        case .right:
            HStack(alignment: .bottom, spacing: 0) {
                Spacer()
                uploadDocumentView()
                statusError(scheme: scheme)
            }.eraseToAnyView()
        }
    }

    // MARK: - Layouts

    private func uploadDocumentView() -> some View {
        VStack(spacing: .zero) {
            if !models.isEmpty {
                ForEach(0..<models.count, id: \.self) { index in
                    UploadDocumentView(
                        model: models[index],
                        cornersOfGroup: getCorners(for: index),
                        direction: direction
                    )
                    .onTapGesture {
                        tappedIndex?(index)
                    }
                }
            }
        }
    }

    private func statusError(scheme: UploadDocumentGridScheme) -> some View {
        VStack(spacing: 0) {
            if isStatusError() {
                SymbolAssets.Service.Solid.error.swiftUIImage
                    .resizable()
                    .padding(LayoutGrid.halfModule)
                    .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
                    .foregroundColor(scheme.errorImageColor.swiftUIColor)
                    .padding(.top, LayoutGrid.module)
                    .padding(.leading, LayoutGrid.module)
                    .onTapGesture {
                        errorAction()
                    }
            }
        }
    }

    private func isStatusError() -> Bool {
        models.contains(where: {$0.status == .error })
    }

}

@available(iOS 14.0.0, *)
private extension UploadDocumentGrid {

    private func getCorners(for index: Int) -> UIRectCorner {
        guard models.count > 1 else {
            return [.allCorners]
        }
        if index == models.count - 1 {
            return [.bottomLeft, .bottomRight]
        } else if index == 0 {
            return [.topLeft, .topRight]
        }
        return []
    }

}

@available(iOS 14.0, *)
struct UploadDocumentGroupView_Previews: PreviewProvider {

    static let testModel = UploadDocument(
        state: .loading,
        fileName: "divide.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static let testModelTwo = UploadDocument(
        state: .loading,
        fileName: "At breakpoint boundaries, mini units divide.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static let testModelThree = UploadDocument(
        state: .loading,
        fileName: "At breakpoint boundaries, mini units divide.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static let testModelFour = UploadDocument(
        state: .loading,
        fileName: "File.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static let testModelFive = UploadDocument(
        state: .description,
        fileName: "At breakpoint boundaries",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static let testModelSix = UploadDocument(
        state: .download,
        fileName: "At breakpoint boundaries, mini units divide.pdf",
        fileSize: "65,6 МБ",
        time: "14:52",
        status: .sent
    )

    static var previews: some View {
        UploadDocumentGrid(models: [testModel, testModelTwo, testModelThree], direction: .left)
        UploadDocumentGrid(models: [testModelFour, testModelFive, testModelSix], direction: .right)
    }

}
