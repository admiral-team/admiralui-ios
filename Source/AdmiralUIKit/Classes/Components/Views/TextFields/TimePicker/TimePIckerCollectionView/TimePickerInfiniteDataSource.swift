//
//  TimePickerInfiniteDataSource.swift
//  AdmiralUI
//
//  Created on 15.03.2021.
//

import Foundation

final class TimePickerInfiniteDataSource {
    
    // MARK: - Internal Properties
    
    var maxNumber: Int = 60 {
        didSet { reloadData() }
    }
    
    var minNumber: Int = 0 {
        didSet { reloadData() }
    }
    
    var repeatingCount: Int = Constants.defaultRepeatingCount {
        didSet { reloadData() }
    }

    var numberOfItems: Int {
        return min(data.count * repeatingCount, Constants.defaultMaxItemsCount)
    }
    
    var interval: Int? {
        didSet { reloadData() }
    }
    
    // MARK: - Private Properties

    private enum Constants {
        static let defaultMaxNumber = 60
        static let defaultRepeatingCount = 1000
        static let defaultMaxItemsCount = 61000
    }
    
    private var data: [Int] = []
    
    // MARK: - Initializers
    
    init() {
        reloadData()
    }
    
    // MARK: - Public Methods
    
    func itemData(for rowIndex: Int) -> Int? {
        guard !data.isEmpty else { return nil }
        return data[rowIndex % data.count]
    }
    
    func middleItemIndex(for number: Int) -> Int {
        let middle = (repeatingCount / 2)
        let startIndex = middle * data.count
        return startIndex + (data.firstIndex(of: number) ?? 0)
    }
    
    // MARK: - Private Methods
    
    private func reloadData() {
        let dataArray = Array(minNumber...maxNumber)
        if
            let step = interval,
            dataArray.count % step == 0 {
            var data = [Int]()
            for i in dataArray {
                if i % step == 0 {
                    data.append(i)
                }
            }
            self.data = data
        } else {
            data = dataArray
        }
    }
    
}
