//
//  String+TimePicker.swift
//  AdmiralUI
//
//  Created on 17.03.2021.
//

import Foundation

public extension String {
    
    func timeToHours(format: String, isAMPM: Bool = false) -> String? {
        guard let intTime = Int(self) else { return nil }
        
        let maxHours = isAMPM ? 12 : 24
        
        var hours = String(intTime % maxHours)
        
        if intTime > maxHours {
            hours = String(intTime % 10)
        }
        
        let dateAsString = hours
        let dateFormat: String = isAMPM ? "h" : "HH"
        let df = DateFormatter()
        df.dateFormat = dateFormat
        
        let dateOptional = df.date(from: dateAsString)
        
        guard let date = dateOptional else { return nil }
        
        return date.dateToString(dateFormat: dateFormat)
    }
    
    func timeToMinutes(format: String) -> String? {
        guard let intTime = Int(self) else { return nil }
        
        var minutes = String(intTime % 60)
        
        if intTime > 59 {
            minutes = String(intTime % 10)
        }
        
        let dateAsString = minutes
        let df = DateFormatter()
        df.dateFormat = format
        
        let dateOptional = df.date(from: dateAsString)
        df.dateFormat = format
        
        guard let date = dateOptional else { return nil }
        
        let time = df.string(from: date)
        return time
    }
    
}
