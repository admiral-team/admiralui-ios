//
//  UploadingImageViewMolde.swift
//  ExampleiOS
//
//  Created by on 5.05.2022.
//

import AdmiralUIKit
import Foundation

final class UploadingImageViewModel {

    // MARK: - Internal properties

    var uploadImages: [UploadingGridItem] = [
        UploadingGridItem(
            models: [
                UploadImageItem(
                    image: Asset.Chat.photo.image,
                    style: .default
                )
            ],
            titleLabelText: "One file",
            chatTime: "21:21",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 2),
            titleLabelText: "Two files",
            chatTime: "21:22",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 3),
            titleLabelText: "Three files",
            chatTime: "21:23",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 4),
            titleLabelText: "Four files",
            chatTime: "21:24",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 5),
            titleLabelText: "Five files",
            chatTime: "21:24",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 6),
            titleLabelText: "Six files",
            chatTime: "21:24",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 4),
            titleLabelText: "Sent with error",
            chatTime: "21:24",
            chatDirection: .right,
            state: .error
        ),
        UploadingGridItem(
            models: [],
            titleLabelText: "",
            chatTime: "",
            chatDirection: .left,
            state: .default
        ),
        UploadingGridItem(
            models: [],
            titleLabelText: "",
            chatTime: "",
            chatDirection: .left,
            state: .default
        )
    ]

    // MARK: - Internal Methods

    func changeState(by value: Int) {
        uploadImages.enumerated().forEach { index, _ in
            _ = uploadImages[index].models.enumerated().map { modelIndex, _ in
                uploadImages[index].models[modelIndex].state = value == 1 ? .loading : .default
            }
        }
    }

}
