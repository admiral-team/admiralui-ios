//
//  SwiftUIUploadingPhotoView.swift
//  ExampleiOS
//
//  Created on 09.11.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme

@available(iOS 14.0.0, *)
struct SwiftUIUploadingPhotoView: View {

    // MARK: - Private properties

    @StateObject private var viewModel = SwiftUIUploadingPhotoViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "Uploading Photo",
            navigationBarDisplayMode: .large
        ) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Loading"], selection: $viewModel.isEnabledControlsState)
                VStack(alignment: .leading, spacing: LayoutGrid.quadrupleModule) {
                    ForEach(0..<viewModel.gridItems.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: LayoutGrid.halfModule * 5) {
                            Text(viewModel.gridItems[index].title)
                                .font(scheme.textFont.swiftUIFont)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                            UploadingImageGrid(
                                models: viewModel.gridItems[index].models,
                                direction: viewModel.gridItems[index].direction,
                                errorAction: {
                                    viewModel.errorGridIndex = index
                                    viewModel.showActionSheet = true
                                }
                            )
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule * 2)
                }
                .padding(.top, LayoutGrid.quadrupleModule)
            }
            .actionSheet(isPresented: $viewModel.showActionSheet,
                         content: getActionSheet )
            .padding()
        }
        .onDisappear { viewModel.action = .stopTimer }
    }
    
    private func getActionSheet() -> ActionSheet {
        let scheme = schemeProvider.scheme
        let repeatSent: ActionSheet.Button = .default(
            Text("Повторить отправку")
                .font(scheme.textFont.swiftUIFont),
            action: { viewModel.action = .reloadGrid }
        )
        let remove: ActionSheet.Button = .default(
            Text("Удалить")
                .font(scheme.textFont.swiftUIFont),
            action: { viewModel.action = .remove }
        )
        let cancel: ActionSheet.Button = .cancel(
            Text("Отмена")
                .font(scheme.textFont.swiftUIFont)
        )
        return ActionSheet(title: Text(""), buttons: [repeatSent, remove, cancel])
    }
    
}
