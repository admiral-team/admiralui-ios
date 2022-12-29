//
//  SwiftUIChatInputViewModel.swift
//  ExampleiOS
//
//  Created on 09.11.2021.
//
// swiftlint:disable all

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

        let id = UUID().uuidString
        let text: String
        let direction: ChatDirection
        let time: String
        let status: ChatStatus?
        let name: String?

        let dateTime: String = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: Date())
        }()

        init(text: String, status: ChatStatus? = nil, direction: ChatDirection = .right, name: String? = nil, time: String = "") {
            self.text = text
            self.status = status
            self.direction = direction
            self.name = name
            self.time = time
        }

        static func == (lhs: SwiftUIChatInputViewModel.ChatMessage, rhs: SwiftUIChatInputViewModel.ChatMessage) -> Bool {
            lhs.id == rhs.id
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
            text: "At breakpoint boundaries, mini units divide",
            direction: .left,
            time: "14:52"
        ),
        ChatMessage(
            text: "Text message",
            direction: .left,
            time: "14:52"
        ),
        ChatMessage(
            text: "At breakpoint boundaries, miniunits divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.",
            status: .loading,
            direction: .right,
            time: "14:52"
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
                self?.messages.append(ChatMessage(text: text, status: .read))
                self?.text = ""
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
