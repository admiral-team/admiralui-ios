//
//  SwiftUIChatInputView.swift
//  ExampleiOS
//
//  Created on 08.11.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import AdmiralUIResources
import Combine

@available(iOS 14.0.0, *)
struct SwiftUIChatInputView: View {
    
    // MARK: - Private Properties

    @State private var isEnabledControlsState: Int = 0
    @State private var viewSize: CGSize = .zero
    @State private var messageSended = false

    @StateObject private var viewModel = SwiftUIChatInputViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "Input",
            isShowThemeSwitchSwiftUIView: false
        ) {
            scheme.backgroundColor.swiftUIColor
            VStack {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding(.horizontal, LayoutGrid.doubleModule)
                VStack(spacing: LayoutGrid.module) {
                    messagesScrollView
                    chatInput
                }
                .padding(.top, LayoutGrid.doubleModule)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
            }
            .onTapGesture { viewModel.isResponder = false }
        }
    }

    @ViewBuilder
    private var messagesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { reader in
                LazyVStack {
                    ForEach(viewModel.messages, id: \.id) { message in
                        switch message.state {
                        case .image(let model):
                            HStack {
                                Spacer()
                                UploadingImageGrid(model: model, direction: .right)
                            }
                        case .document(let model):
                            HStack {
                                Spacer()
                                UploadDocumentGrid(model: model, direction: .right)
                            }
                        case .message(let direction):
                            ChatBubbleView(
                                text: message.text,
                                direction: direction,
                                time: message.time,
                                status: message.status
                            )
                        }
                    }
                }
                .onChange(of: viewModel.messages) { _ in
                    DispatchQueue.main.async {
                        withAnimation { reader.scrollTo(viewModel.messages.last?.id) }
                    }
                }
                .onChange(of: viewSize) { _ in
                    DispatchQueue.main.async {
                        withAnimation { reader.scrollTo(viewModel.messages.last?.id) }
                    }
                }
                .onChange(of: messageSended) { value in
                    guard value == true else { return }

                    DispatchQueue.main.async {
                        withAnimation { reader.scrollTo(viewModel.messages.last?.id) }
                    }
                    messageSended = false
                }
            }
        }
        .padding(.horizontal, LayoutGrid.doubleModule)
    }

    private var chatInput: some View {
        ChatInput(
            value: $viewModel.text,
            contentType: .default,
            returnKeyType: .send,
            autocapitalizationType: .none,
            autocorrectionType: .default,
            isResponder: $viewModel.isResponder,
            placeholder: "Введите сообщение",
            tapSendButton: {
                viewModel.addMessageseSubject.send(())
                messageSended = true
                return true
            },
            tapFileButton: { viewModel.showingActionSheet = true },
            isShowFileButton: true,
            formatter: BlocFormatter(format: { text in
                return text?.replacingOccurrences(of: "=)", with: "🙂")
            })
        )
        .modifier(SizeAwareViewModifier(viewSize: $viewSize))
        .disabled(isEnabledControlsState != 0)
        .padding(.horizontal, LayoutGrid.doubleModule)
    }
}
