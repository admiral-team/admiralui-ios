//
//  SwiftUIUploadingFile.swift
//  ExampleiOS
//
//  Created on 08.11.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct SwiftUIUploadingFileView: View {
    
    // MARK: - Private properties
    
    @StateObject private var viewModel = SwiftUIUploadFileViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "Uploading Files",
            navigationBarDisplayMode: .large
        ) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: ["Default", "Loading"], selection: $viewModel.isEnabledControlsState)
                
                documentsView()
                    .padding(.top, LayoutGrid.tripleModule)
            }
            .actionSheet(isPresented: $viewModel.showActionSheet,
                         content: getActionSheet)
            .padding()
        }
        .onDisappear {
            viewModel.action = .stopTimer
        }
    }
    
    private func documentsView() -> some View {
        VStack(spacing: LayoutGrid.module) {
            ForEach(0..<viewModel.gridItems.count, id: \.self) { index in
                UploadDocumentGrid(
                    models: viewModel.gridItems[index].models,
                    direction: viewModel.gridItems[index].direction,
                    tappedIndex: { tapIndex in
                        viewModel.action = .tap(grid: index, item: tapIndex)
                    },
                    errorAction: {
                        viewModel.errorGridIndex = index
                        viewModel.showActionSheet = true
                    }
                )
            }
        }
    }
    
    private func getActionSheet() -> ActionSheet {
        let scheme = schemeProvider.scheme
        
        let repeatSent: ActionSheet.Button = .default(Text("Повторить отправку")
                                                        .font(scheme.textFont.swiftUIFont),
                                                      action: {
                                                        viewModel.action = .reloadGrid
                                                      })
        let remove: ActionSheet.Button = .default(Text("Удалить")
                                                    .font(scheme.textFont.swiftUIFont),
                                                  action: {
                                                    viewModel.action = .remove
                                                  })
        let cancel: ActionSheet.Button = .cancel(Text("Отмена")
                                                    .font(scheme.textFont.swiftUIFont))
        
        return ActionSheet(title: Text(""), buttons: [repeatSent, remove, cancel])
    }
    
}
