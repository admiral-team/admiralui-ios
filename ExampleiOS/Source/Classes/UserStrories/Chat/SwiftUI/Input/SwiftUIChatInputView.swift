//
//  SwiftUIChatInputView.swift
//  ExampleiOS
//
//  Created on 08.11.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import Combine

@available(iOS 14.0.0, *)
struct SwiftUIChatInputView: View {
    
    // MARK: - Private Properties

    @State private var isEnabledControlsState: Int = 0
    @State private var viewSize: CGSize = .zero

    // MARK: - NameSpace

    @Namespace var bottomID

    // MARK: - Private Properties

    @StateObject private var viewModel = SwiftUIChatInputViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
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
                    ScrollViewReader { proxy in
                        messagesScrollView(proxy: proxy)
                        chatInput(proxy: proxy)
                    }
                }
                .padding(.top, LayoutGrid.doubleModule)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
            }
            .onTapGesture { viewModel.isResponder = false }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func messagesScrollView(proxy: ScrollViewProxy) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(viewModel.messages, id: \.id) { message in
                    if message.id == viewModel.messages.last?.id {
                        ChatBubbleView(
                            text: message.text,
                            direction: message.direction,
                            time: message.time,
                            status: message.status,
                            name: message.name
                        )
                        .id(bottomID)
                    } else {
                        ChatBubbleView(
                            text: message.text,
                            direction: message.direction,
                            time: message.time,
                            status: message.status,
                            name: message.name
                        )
                    }
                }
            }
        }
        .onChange(of: viewSize) { _ in
            proxy.scrollTo(bottomID)
        }
        .onChange(of: viewModel.messages) { _ in
            proxy.scrollTo(bottomID)
        }
        .padding(.horizontal, LayoutGrid.doubleModule)
    }

    private func chatInput(proxy: ScrollViewProxy) -> some View {
        ChatInput(
            value: $viewModel.text,
            contentType: .default,
            returnKeyType: .send,
            autocapitalizationType: .none,
            autocorrectionType: .default,
            isResponder: $viewModel.isResponder,
            placeholder: "Введите сообщение",
            tapSendButton: { [weak viewModel] in
                viewModel?.addMessageseSubject.send(())
                proxy.scrollTo(bottomID)
                return true
            },
            tapFileButton: { [weak viewModel] in viewModel?.showingActionSheet = true },
            isShowFileButton: true,
            formatter: BlocFormatter(format: { text in
                text?.replacingOccurrences(of: "=)", with: "🙂")
            })
        )
        .modifier(SizeAwareViewModifier(viewSize: $viewSize))
        .disabled(isEnabledControlsState != 0)
        .padding(.horizontal, LayoutGrid.doubleModule)
    }

}
