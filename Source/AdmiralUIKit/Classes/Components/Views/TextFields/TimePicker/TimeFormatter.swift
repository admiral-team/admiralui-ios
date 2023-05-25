//
//  TimeFormatter.swift
//  AdmiralUIKit
//
//  Created on 18.03.2021.
//

import Foundation

enum TimeFormatterType {
    case min
    case hours
    case all
}

struct TimeFormatter {
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let doubleHourFormat: String = "HH"
        static let singleHourFormat: String = "h"
        static let doubleMinuteFormat: String = "mm"
        static let singleMinuteFormat: String = "m"
    }
    
    // MARK: - Public Methods
    
    func prepareTime(currentText: String, newDigit: String, type: TimeFormatterType) -> (String, String) {
        switch type {
        case .min:
            let min = prepareMinTime(currentText: currentText, newDigit: newDigit)
            return ("", min)
        case .hours:
            let hours = prepareHours(currentText: currentText, newDigit: newDigit)
            return (hours, "")
        case .all:
            return prepareAllTime(currentText: currentText, newDigit: newDigit)
        }
    }
    
    func usesAMPM() -> Bool {
        let locale = NSLocale.current
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)!
        if dateFormat.range(of: "a", options: .literal) != nil {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: - Private Methods
    
    private func prepareAllTime(currentText: String, newDigit: String) -> (String, String) {
        var text = currentText + newDigit
        
        if text.count > 4 {
            text = String(text.dropFirst())
        }
        
        if text.count == 1 {
            return ("", text)
        } else if text.count == 2 {
            if
                let intText = Int(String(text)),
                let intDigit = Int(newDigit),
                intText > 60,
                intDigit > 6 {
                return ("", "0\(newDigit)")
            } else {
                return ("", text)
            }
        } else if text.count == 3 {
            guard
                let textFirst = currentText.first,
                let textLast = currentText.last else { return ("", "") }
            
            var minText = String(textLast) + newDigit
            if
                let intNewDigit = Int(String(newDigit)),
                let minTextInt = Int(minText),
                minTextInt > 60,
                intNewDigit > 5 {
                minText = "0\(newDigit)"
            }
            
            return (String(textFirst), minText)
        } else if text.count == 4 {
            guard
                let hours = String(text.prefix(2)).timeToHours(format: Constants.doubleHourFormat, isAMPM: usesAMPM()),
                let textLast = currentText.last else { return ("", "") }
            
            var min = String(textLast) + newDigit
            
            if
                let intMinText = Int(min),
                let intNewDigit = Int(newDigit),
                intMinText > 60,
                intNewDigit > 6 {
                min = "0\(newDigit)"
            }
                
            return (hours, min)
        }
        return ("", "")
    }
    
    private func prepareHours(currentText: String, newDigit: String) -> String {
        var text = currentText
        
        if text.count == 2 {
            text.removeFirst()
        }
        
        text += newDigit
        
        if text.count == 1 {
            return text.timeToHours(format: Constants.singleHourFormat, isAMPM: usesAMPM()) ?? ""
        } else if text.count == 2 {
            return text.timeToHours(format: Constants.doubleHourFormat, isAMPM: usesAMPM()) ?? ""
        }
        
        return ""
    }
    
    private func prepareMinTime(currentText: String, newDigit: String) -> String {
        var text = currentText
        
        if text.count == 2 {
            text.removeFirst()
        }
        
        text += newDigit
        
        if text.count == 1 {
            return text.timeToMinutes(format: Constants.singleMinuteFormat) ?? ""
        } else if text.count == 2 {
            return text.timeToMinutes(format: Constants.doubleMinuteFormat) ?? ""
        }
        
        return ""
    }
    
}
