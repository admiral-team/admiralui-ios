//
//  ParagraphSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 26.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ParagraphSwiftUIViewModel: ObservableObject {

    final class ParagraphStorage {

        // MARK: - Properties

        let title: String
        let items: [ParagraphItem]

        // MARK: - Initializer

        init(items: [ParagraphItem], title: String) {
            self.items = items
            self.title = title
        }

    }

    struct ParagraphItem: Hashable {
        let id = UUID().uuidString
        let trailingImage: Image?
        let textAligment: TextAlignment
        let paragraphImageType: ParagraphLeadingImageType?
        let paragraphStyle: ParagraphStyle
        let title: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(textAligment)
            hasher.combine(title)
            hasher.combine(paragraphStyle)
        }

        static func == (lhs: ParagraphItem, rhs: ParagraphItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var items: [ParagraphStorage]
    @Published var isEnabledControlsState: Int = 0

    // MARK: - Internal Properties

    var title: String {
        "Paragraph"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    // swiftlint:disable line_length
    init() {
        items = [
            .init(items: [
                ParagraphItem(trailingImage: nil, textAligment: .leading, paragraphImageType: .point, paragraphStyle: .primary, title: "Lorem ipsum dolor sit amet"),
                ParagraphItem(trailingImage: nil, textAligment: .leading, paragraphImageType: .check, paragraphStyle: .primary, title: "Lorem ipsum dolor sit amet"),
                ParagraphItem(trailingImage: nil, textAligment: .leading, paragraphImageType: nil, paragraphStyle: .primary, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
                ParagraphItem(trailingImage: AdmiralUIResources.AssetSymbol.Service.Outline.info.image, textAligment: .leading, paragraphImageType: nil, paragraphStyle: .primary, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
                ParagraphItem(trailingImage: nil, textAligment: .center, paragraphImageType: nil, paragraphStyle: .primary, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")

            ], title: "Primary"),
            .init(items: [
                ParagraphItem(trailingImage: nil, textAligment: .leading, paragraphImageType: .point, paragraphStyle: .secondary, title: "Lorem ipsum dolor sit amet"),
                ParagraphItem(trailingImage: nil, textAligment: .leading, paragraphImageType: .check, paragraphStyle: .secondary, title: "Lorem ipsum dolor sit amet"),
                ParagraphItem(trailingImage: nil, textAligment: .leading, paragraphImageType: nil, paragraphStyle: .secondary, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
                ParagraphItem(trailingImage: AdmiralUIResources.AssetSymbol.Service.Outline.info.image, textAligment: .leading, paragraphImageType: nil, paragraphStyle: .secondary, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
                ParagraphItem(trailingImage: nil, textAligment: .center, paragraphImageType: nil, paragraphStyle: .secondary, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
            ], title: "Secondary")
        ]

    }

}
