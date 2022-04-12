//
//  SwiftUIChatInputViewModel.swift
//  ExampleiOS
//
//  Created on 09.11.2021.
//

import Combine
import UIKit
import SwiftUI
import AdmiralSwiftUI
import Foundation

@available(iOS 14.0.0, *)
final class SwiftUIChatInputViewModel: ObservableObject {

    enum AtttachmentsViewStyle {
        case files
        case images
    }
    
    struct ChatMessage: Identifiable, Equatable {
        static func == (lhs: SwiftUIChatInputViewModel.ChatMessage, rhs: SwiftUIChatInputViewModel.ChatMessage) -> Bool {
            lhs.id == rhs.id
        }

        enum State {
            case message(direction: ChatDirection)
            case image(model: UploadImageModel)
            case document(model: UploadDocument)
        }

        let dateTime: String = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: Date())
        }()

        let id = UUID().uuidString
        let state: State
        let text: String
        let time: String
        let status: ChatStatus?

        init(text: String, state: State, status: ChatStatus? = nil) {
            self.text = text
            self.state = state
            self.status = status
            time = dateTime
        }
    }

    // MARK: - Properties

    /// Handle files from Files App
    @Published var handleFileUrl: Result<[URL], Error>?

    /// Handle image from gallery
    @Published var handleImage: UIImage?

    ///  Messages list
    @Published var messages = [
        ChatMessage(
            text: "Привет, какой у Вас вопрос?",
            state: .message(direction: .left)
        )
    ]

    /// Text input
    @Published var text: String? = ""

    /// ActionSheet mark to show
    @Published var showingActionSheet = false

    /// AttachmentView mark to show
    @Published var showingAttachmentView = false

    /// Responder value for chatInput
    @Published var isResponder: Bool = false

    /// Subject that used to show attachmentView and close actionSheet
    let atttachmentsViewStyleSubject = PassthroughSubject<AtttachmentsViewStyle, Never>()

    /// Subject uset to listen actions for adding messages
    let addMessageseSubject = PassthroughSubject<Void, Never>()

    /// The style of attachmentView. Showing documentPicker or imageGalleryPicker
    var attachmentsStyle: AtttachmentsViewStyle = .images

    /// Dispose bag
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init/deinit

    init() {
        bindPublishers()
    }

    // MARK: - Binding

    private func bindPublishers() {
        addMessageseSubject
            .sink { [weak self] _ in
                guard let text = self?.text,
                      !text.isEmpty
                else {
                    return
                }
                self?.messages.append(
                    ChatMessage(
                        text: text,
                        state: .message(direction: .right),
                        status: .read
                    )
                )
                self?.text = ""
            }
            .store(in: &cancellables)

        $handleImage
            .dropFirst()
            .sink { [weak self] image in
                guard let image = image else { return }
                self?.messages.append(
                    ChatMessage(
                        text: self?.text ?? "",
                        state: .image(
                            model: UploadImageModel(
                                isLoading: true,
                                time: "12:53",
                                backgroundImage: Image(uiImage: image),
                                uploadStatus: .receive
                            )
                        )
                    )
                )
            }
            .store(in: &cancellables)

        $handleFileUrl
            .dropFirst()
            .sink { [weak self] _ in
                let testModel = UploadDocument(
                    state: .loading,
                    fileName: "At breakpoint boundaries",
                    fileSize: "65,6 МБ",
                    time: "14:52"
                )
                self?.messages.append(ChatMessage(text: self?.text ?? "", state: .document(model: testModel)))
            }
            .store(in: &cancellables)

        atttachmentsViewStyleSubject
            .sink { [weak self] style in self?.updateAtttachmentsViewStyle(style: style) }
            .store(in: &cancellables)
    }

    // MARK: - Private methods

    private func updateAtttachmentsViewStyle(style: AtttachmentsViewStyle) {
        showingActionSheet = false
        showingAttachmentView = true
        attachmentsStyle = style
    }

}
