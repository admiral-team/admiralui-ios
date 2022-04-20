//
//  SwiftUITextOperationViewModel.swift
//  ExampleiOS
//
//  Created on 02.02.2022.
//

import SwiftUI
import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class SwiftUITextOperationViewModel: ObservableObject {

    enum Action {
        case reload
        case remove
    }

    struct TextOperationItem: Identifiable {
        var id = UUID().uuidString
        var style: TextOperationViewStyle
        var chatStatus: ChatStatus?
        var direction: ChatDirection
        var time: String
        var title: String
        var description: String
        var rowTitle: String

        init(
            style: TextOperationViewStyle,
            chatStatus: ChatStatus?,
            direction: ChatDirection = .left,
            time: String,
            title: String,
            description: String,
            rowTitle: String,
            errorAction: @escaping () -> Void = {}
        ) {
            self.style = style
            self.chatStatus = chatStatus
            self.direction = direction
            self.time = time
            self.title = title
            self.description = description
            self.chatStatus = chatStatus
            self.direction = direction
            self.rowTitle = rowTitle
        }
    }
        
    // MARK: - Published properties

    @Published var action: Action?
    @Published var showActionSheet: Bool = false

    @Published var items = [
        TextOperationItem(
            style: .default,
            chatStatus: nil,
            direction: .left,
            time: "21:21",
            title: "+ 35 000 ₽",
            description: "НПО «Ромашка»",
            rowTitle: "Default"
        ),
        TextOperationItem(
            style: .success,
            chatStatus: nil,
            direction: .left,
            time: "21:21",
            title: "+ 35 000 ₽",
            description: "НПО «Ромашка»",
            rowTitle: "Success"
        ),
        TextOperationItem(
            style: .error,
            chatStatus: .error,
            direction: .left,
            time: "21:21",
            title: "+ 35 000 ₽",
            description: "НПО «Ромашка»",
            rowTitle: "Error"
        )
    ]

    // MARK: - Interval properties

    var selectedIndex: Int?

    var title: String {
        "Text Operation"
    }

    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init/deinit

    init() {
        $action
            .filterNil()
            .sink { [weak self] value in
                guard let index = self?.selectedIndex else { return }

                switch value {
                case .reload:
                    self?.items[index].chatStatus = .loading
                    self?.reloadTimer()
                case .remove:
                    self?.items.remove(at: index)
                }
            }
            .store(in: &cancellables)
    }
    
    private func reloadTimer() {
        let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        var counter = 0
        timer
            .map { _ in counter += 1 }
            .sink { [weak self] _ in
                if counter == 4 {
                    guard let endIndex = self?.items.endIndex else { return }

                    self?.items[endIndex].chatStatus = .error
                } else if counter > 4 {
                    timer.upstream.connect().cancel()
                }
            }
            .store(in: &cancellables)
    }
}
