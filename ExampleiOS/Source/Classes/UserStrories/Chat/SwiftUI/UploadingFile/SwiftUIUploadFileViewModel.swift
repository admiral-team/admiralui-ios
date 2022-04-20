//
//  SwiftUIUploadFIleViewModel.swift
//  ExampleiOS
//
//  Created on 08.11.2021.
//

import SwiftUI
import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class SwiftUIUploadFileViewModel: ObservableObject {
    
    enum Action {
        case tap(grid: Int, item: Int)
        case reloadGrid
        case remove
        case stopTimer
    }
    
    struct UploadGridItem {
        var models: [UploadDocument]
        let direction: ChatDirection
        
        mutating func setState(state: UploadDocumentState) {
            models.enumerated().forEach { index, _ in
                models[index].state = state
            }
        }
        
        mutating func toggleState(index: Int) {
            models[index].state = models[index].state == .loading ? .download : .loading
        }
        
    }
    
    // MARK: - Published properties
    
    @Published var action: Action?
    
    @Published var gridItems = [
        UploadGridItem(
            models: Array(repeating: UploadDocument(
                state: .download,
                fileName: "File.pdf",
                fileSize: "65,6 МБ",
                time: "14:52",
                closeAction: {
                    print("tapped at uploading documents")
                }
            ),
            count: 2),
            direction: .left),
        UploadGridItem(
            models: Array(repeating: UploadDocument(
                state: .download,
                fileName: "File.pdf",
                fileSize: "65,6 МБ",
                time: "14:52",
                status: .error
            ),
            count: 2),
            direction: .right),
        UploadGridItem(
            models: [
                UploadDocument(
                    state: .loading,
                    fileName: "File.pdf",
                    fileSize: "65,6 МБ",
                    time: "14:52"
                )],
            direction: .left)
    ]
    
    @Published var showActionSheet: Bool = false
    @Published var isEnabledControlsState: Int = 0
    
    // MARK: - Internal properties
    
    var errorGridIndex: Int = 0

    var navigationTitle: String {
        "Uploading Files"
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
                self?.setStateForItems(state: value == 0 ? .download : .loading)
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
        setStateForItems(state: .download)
        timerPublisher = nil
    }
    
}

@available(iOS 14.0.0, *)
private extension SwiftUIUploadFileViewModel {
    
    func setStateForItems(state: UploadDocumentState) {
        gridItems.enumerated().forEach { index, _ in
            gridItems[index].setState(state: state)
        }
    }
    
    func reloadGrid() {
        gridItems[errorGridIndex].setState(state: .loading)
    }
    
    func reloadItem(grid: Int, item: Int) {
        gridItems[grid].toggleState(index: item)
    }
    
    func removeGrid() {
        gridItems.remove(at: errorGridIndex)
    }
    
}
