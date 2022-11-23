//
//  SwiftUITextMessageViewModel.swift
//  ExampleiOS
//
//  Created on 31.01.2022.
//
// swiftlint:disable all

import SwiftUI
import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class SwiftUITextMessageViewModel: ObservableObject {
    
    struct ChatBubbleItem: Identifiable {
        var id = UUID().uuidString

        let text: String
        var direction: ChatDirection
        var time: String
        var status: ChatStatus?
        var name: String?
        var isRoundAllCorners: Bool = false
        let maxWidth: CGFloat?
        
        init(
            text: String,
            direction: ChatDirection,
            time: String,
            status: ChatStatus? = nil,
            name: String? = nil,
            isRoundAllCorners: Bool = false,
            maxWidth: CGFloat? = nil) {
            self.text = text
            self.direction = direction
            self.time = time
            self.status = status
            self.name = name
            self.isRoundAllCorners = isRoundAllCorners
            self.maxWidth = maxWidth
        }
    }
        
    // MARK: - Published properties
    
    @Published var reloadTestModel: Void = ()
    @Published var removeTestModel: Void = ()
    @Published var showActionSheet: Bool = false
    
    @Published var chatBubleItems = [
        ChatBubbleItem(
            text: "Hello",
            direction: .right,
            time: "14:52",
            status: .read,
            isRoundAllCorners: true
        ),
        ChatBubbleItem(
            text: "At breakpoint boundaries, miniunits divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.",
            direction: .right,
            time: "14:52",
            status: .loading,
            isRoundAllCorners: true
        ),
        ChatBubbleItem(
            text: "At breakpoint boundaries, mini units divide",
            direction: .left,
            time: "14:52",
            status: .read,
            name: "Татьяна"
        ),
        ChatBubbleItem(
            text: "Text message",
            direction: .left,
            time: "14:52",
            status: .read
        ),
        ChatBubbleItem(
            text: "At breakpoint boundaries, miniunits divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.",
            direction: .right,
            time: "14:52",
            status: .read,
            isRoundAllCorners: true
        )
    ]
    
    // MARK: - Private properties

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init/deinit

    init() {
        $reloadTestModel
            .dropFirst()
            .sink { [weak self] _ in
                self?.chatBubleItems[2].status = .loading
                self?.reloadTimer()
            }
            .store(in: &cancellables)
        
        $removeTestModel
            .dropFirst()
            .sink { [weak self] _ in
                self?.chatBubleItems.remove(at: 2)
            }
            .store(in: &cancellables)
    }
    
    func reloadTimer() {
        let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        var counter = 0
        timer
            .map { _ in counter += 1 }
            .sink { [weak self] _ in
                if counter == 4 {
                    self?.chatBubleItems[2].status = .error
                } else if counter > 4 {
                    timer.upstream.connect().cancel()
                }
            }
            .store(in: &cancellables)
    }
}
