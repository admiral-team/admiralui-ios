//
//  Date+TimePicker.swift
//  AdmiralUI
//
//  Created on 17.03.2021.
//

import Foundation

extension Date {
    
    func combineHoursAndMinutes(hours: Date, minutes: Date) -> Date {
        let calendar = Calendar.current
        
        let hourComponents = calendar.dateComponents([.hour], from: hours)
        let minutesComponetns = calendar.dateComponents([.minute], from: minutes)
        
        var mergedComponments = DateComponents()
        
        if let hours = hourComponents.hour {
            mergedComponments.hour = hours
        }
        
        if let minutes = minutesComponetns.minute {
            mergedComponments.minute = minutes
        }
        
        return calendar.date(from: mergedComponments) ?? Date()
    }
    
    var zeroDate: Date {
        let calendar = Calendar.current
        return calendar.date(
            bySettingHour: 0,
            minute: 0,
            second: 0,
            of: Date(),
            direction: .backward) ?? Date()
    }
    
}
