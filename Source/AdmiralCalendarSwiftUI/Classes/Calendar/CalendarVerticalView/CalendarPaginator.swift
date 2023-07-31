//
//  CalendarPaginator.swift
//  AdmiralCalendarSwiftUI
//
//  Created by on 29.07.2023.
//  
//

import Combine
import Foundation

@available(iOS 14.0, *)
final class CalendarPaginator: ObservableObject {

    // MARK: - Published Properties

    @Published var paginationAction: Void = ()
    @Published var paginationTopAction: Void = ()
    @Published var dates = [Date]()
    @Published var isLoading = false
    @Published var lastShownDate: Date?

    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    init() {
        bindPublishers()
    }

    // MARK: - Private Methods

    private func bindPublishers() {
        $paginationAction
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.addPreviousMonth()
                self?.isLoading = false
            }
            .store(in: &cancellables)

        $paginationTopAction
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.addNextMonths()
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

    func setupInitialDates(completion: @escaping (([Date], Date)) -> () ) {
        let currentDate = Date()
        let previousDates = (1...20).map { Calendar.current.date(byAdding: .month, value: -$0, to: Date()) ?? Date()}
        let nextDates = (1...20).map { Calendar.current.date(byAdding: .month, value: $0, to: Date()) ?? Date()}
        let arr = previousDates + [currentDate] + nextDates
        dates = arr
            .sorted(by: { $0.compare($1) == .orderedAscending })
        completion((dates, currentDate))
    }

    private func addPreviousMonth() {
        guard let date = dates.first else { return }
        let previousMonths = (1...20).map { Calendar.current.date(byAdding: .month, value: -$0, to: date) ?? Date()}
        DispatchQueue.main.async {
            var datesCopy = self.dates
            datesCopy.removeSubrange(self.dates.count - 20...self.dates.count - 1)
            self.dates = (previousMonths + datesCopy).sorted(by: { $0.compare($1) == .orderedAscending })
            self.lastShownDate = datesCopy.first
        }
    }

    private func addNextMonths() {
        guard let date = dates.last else { return }
        let nextMonths = (1...20).map { Calendar.current.date(byAdding: .month, value: $0, to: date) ?? Date()}
        DispatchQueue.main.async {
            var datesCopy = self.dates
            datesCopy.removeSubrange(0...20)
            self.dates = (datesCopy + nextMonths).sorted(by: { $0.compare($1) == .orderedAscending })
            self.lastShownDate = date
        }
    }
}
