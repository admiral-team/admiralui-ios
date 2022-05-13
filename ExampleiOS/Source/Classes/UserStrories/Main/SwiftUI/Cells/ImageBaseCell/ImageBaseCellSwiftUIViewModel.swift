//
//  ImageBaseCellSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class ImageBaseCellSwiftUIViewModel: ObservableObject {

    enum ImageBaseCellSwiftUIItem: Int, CaseIterable {
        case lable
        case leading
        case trailing

        var title: String {
            switch self {
            case .lable:
                return "Leading Elements"
            case .leading:
                return "Center Elements"
            case .trailing:
                return "Trailing Elements"
            }
        }
    }


    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Base Cells vs Image"
    }

}
