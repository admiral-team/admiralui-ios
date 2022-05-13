//
//  UploadingFileViewModel.swift
//  ExampleiOS
//
//  Created on 12.05.2022.
//

import AdmiralUIKit
import Foundation

final class UploadingFileViewModel {

    // MARK: - Internal properties

    var uploadFiles = [
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 1.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 2.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 4.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 5.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 7.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 8.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 9.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 10.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 11.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 12.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        )
    ]

    // MARK: - Internal Methods

    func changeState(by value: Int) {
        uploadFiles.enumerated().forEach { index, _ in
            uploadFiles[index].state = value == 1 ? .loading : .download
        }
    }

}
