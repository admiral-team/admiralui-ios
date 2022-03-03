//
//  FilesPickerView.swift
//  ExampleiOS
//
//  Created on 27.10.2021.
//

import SwiftUI
import UniformTypeIdentifiers

@available(iOS 14.0.0, *)
struct FilesPickerView: UIViewControllerRepresentable {

    // MARK: - Coordinator

    final class Coordinator: NSObject, UIDocumentPickerDelegate {

        // MARK: - Properties
        let parent: FilesPickerView

        // MARK: - Init/Deinit
        init(parent: FilesPickerView) {
            self.parent = parent
        }

        // MARK: - Internal methods
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.completion(urls)
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.completion([])
        }

    }

    // MARK: - Properties

    let completion: ([URL]) -> Void

    // MARK: - Internal methods

    func makeUIViewController(context: UIViewControllerRepresentableContext<FilesPickerView>) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: UTType.allowedTypes)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(
        _ uiViewController: UIDocumentPickerViewController,
        context: UIViewControllerRepresentableContext<FilesPickerView>
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

}

@available(iOS 14.0.0, *)
private extension UTType {

    static var allowedTypes: [UTType] {
        let allowedTypes = ["docx", "xls", "msword", "doc", "docx", "xlsx"].compactMap { getUTType(by: $0) }
        return [.pdf, .image, .plainText, .text, .jpeg, .png] + allowedTypes
    }

    private static func getUTType(by fileExtension: String) -> UTType? {
        types(tag: fileExtension, tagClass: .filenameExtension, conformingTo: nil).first
    }

}
