//
//  SwiftUITextMessage.swift
//  ExampleiOS
//
//  Created on 08.11.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct SwiftUITextMessageView: View {

    @StateObject private var viewModel = SwiftUITextMessageViewModel()
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "Text Messages",
            isShowThemeSwitchSwiftUIView: false,
            navigationBarDisplayMode: .large
        ) {
            scheme.backgroundColor.swiftUIColor
            ZStack {
                scheme.backgroundColor.swiftUIColor
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: LayoutGrid.module) {
                        ForEach(viewModel.chatBubleItems) { item in
                            ChatBubbleView(
                                text: item.text,
                                direction: item.direction,
                                time: item.time,
                                status: item.status,
                                errorAction: { viewModel.showActionSheet = true })
                        }
                    }
                }
                .actionSheet(isPresented: $viewModel.showActionSheet,
                             content: getActionSheet )
                .padding(LayoutGrid.doubleModule)
            }
        }
    }
    
    private func getActionSheet() -> ActionSheet {
        let scheme = schemeProvider.scheme
        
        let repeatSentButton: ActionSheet.Button = .default(Text("Повторить отправку")
                                                                .font(scheme.textFont.swiftUIFont),
                                                            action: { viewModel.reloadTestModel = () })
        let removeButton: ActionSheet.Button = .default(Text("Удалить")
                                                            .font(scheme.textFont.swiftUIFont),
                                                        action: { viewModel.removeTestModel = () })
        let cancelButton: ActionSheet.Button = .cancel(Text("Отмена")
                                                        .font(scheme.textFont.swiftUIFont))
        
        return ActionSheet(title: Text(""), buttons: [repeatSentButton, removeButton, cancelButton])
    }

}
