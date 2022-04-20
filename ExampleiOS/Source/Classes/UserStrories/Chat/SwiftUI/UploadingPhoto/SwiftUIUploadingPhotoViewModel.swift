//
//  SwiftUIUploadingPhotoViewModel.swift
//  ExampleiOS
//
//  Created on 09.11.2021.
//

import SwiftUI
import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class SwiftUIUploadingPhotoViewModel: ObservableObject {
    
    enum Action {
        case tap(grid: Int, item: Int)
        case reloadGrid
        case remove
        case stopTimer
    }
    
    struct UploadGridItem {
        var models: [UploadImageModel]
        let direction: ChatDirection
        let title: String

        let formater: Formatter = {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en-US")
            formatter.numberStyle = .spellOut
            return formatter
        }()

        init(models: [UploadImageModel], direction: ChatDirection) {
            self.models = models
            self.direction = direction
            self.title = "\(formater.string(for: models.count)?.capitalized ?? "") Files"
        }
        
        mutating func setState(isLoading: Bool) {
            models.enumerated().forEach { index, _ in
                models[index].isLoading = isLoading
            }
        }
        
        mutating func toggleState(index: Int) {
            models[index].isLoading = models[index].isLoading ? false: true
        }
    }
    
    // MARK: - Published properties
    
    @Published var action: Action?
    
    @Published var gridItems = [
        UploadGridItem(
            models: [
                UploadImageModel(
                    isLoading: true,
                    time: "22:36",
                    backgroundImage: Image(uiImage: Asset.Chat.photo.image),
                    uploadStatus: .none,
                    closeAction: { print("tapped at UploadImageModel 1") }
                )
            ],
            direction: .left
        ),
        UploadGridItem(
            models: Array(repeating: UploadImageModel(
                isLoading: true,
                time: "22:36",
                backgroundImage: Image(uiImage: Asset.Chat.photo.image),
                uploadStatus: .none,
                closeAction: { print("tapped at UploadImageModel 2") }
            ),
            count: 2),
            direction: .left
        ),
        UploadGridItem(
            models: Array(repeating: UploadImageModel(
                isLoading: true,
                time: "22:36",
                backgroundImage: Image(uiImage: Asset.Chat.photo.image),
                uploadStatus: .none
            ),
            count: 3),
            direction: .left
        ),
        UploadGridItem(
            models: Array(repeating: UploadImageModel(
                isLoading: true,
                time: "22:36",
                backgroundImage: Image(uiImage: Asset.Chat.photo.image),
                uploadStatus: .none
            ),
            count: 4),
            direction: .left
        ),
        UploadGridItem(
            models: Array(repeating: UploadImageModel(
                isLoading: true,
                time: "22:36",
                backgroundImage: Image(uiImage: Asset.Chat.photo.image),
                uploadStatus: .error
            ),
            count: 5),
            direction: .right
        )
    ]
    
    @Published var showActionSheet: Bool = false
    @Published var isEnabledControlsState: Int = 0
    
    // MARK: - Internal properties
    
    var errorGridIndex: Int = 0

    var navigationTitle: String {
        "Uploading Photo"
    }

    var tabItems: [String] {
        ["Default", "Loading"]
    }
    
    // MARK: - Private properties
    
    private var counter = 0
    private var cancellables = Set<AnyCancellable>()
    private var timerPublisher: AnyCancellable?
    
    // MARK: - Init/deinit
    
    init() {
        startTimer()
        
        $action
            .filterNil()
            .sink { [weak self] value in
                switch value {
                case .tap(let grid, let item):
                    self?.reloadItem(grid: grid, item: item)
                case .reloadGrid:
                    self?.reloadGrid()
                    self?.startTimer()
                case .remove:
                    self?.removeGrid()
                case .stopTimer:
                    self?.stopTimer()
                }
            }
            .store(in: &cancellables)
        
        $isEnabledControlsState
            .dropFirst()
            .sink { [weak self] value in
                self?.setStatusForItems(isLoading: value == 0 ? false : true )
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Private methods
    
    private func startTimer(grid: Int? = nil, item: Int? = nil) {
        timerPublisher = Timer.publish(
            every: 1.0,
            on: .current,
            in: .default
        )
        .autoconnect()
        .sink { [weak self] _ in
            self?.counter += 1
            if self?.counter == 3 {
                self?.stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        counter = 0
        setStatusForItems(isLoading: false)
        timerPublisher = nil
    }
    
}

@available(iOS 14.0.0, *)
private extension SwiftUIUploadingPhotoViewModel {
    
    func setStatusForItems(isLoading: Bool) {
        gridItems.enumerated().forEach { index, _ in
            gridItems[index].setState(isLoading: isLoading)
        }
    }
    
    func reloadGrid() {
        gridItems[errorGridIndex].setState(isLoading: true)
    }
    
    func reloadItem(grid: Int, item: Int) {
        gridItems[grid].toggleState(index: item)
    }
    
    func removeGrid() {
        gridItems.remove(at: errorGridIndex)
    }
    
}
