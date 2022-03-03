//
//  BlocFormatter.swift
//  AdmiralSwiftUI
//
//  Created on 11.08.2021.
//

import Foundation

/**
 BlocFormatter - A Formatter for Text Field for validate the textual representation of values.
 You can create a BlocFormatter by specifying the following parameters in init:
 - format: @escaping (String?) -> String?) - Closure for verification Text Field input text.
 
 ## Example to create BlocFormatter in StandardTextField
 # Code
 ```
 StandardTextField(
     value: .constant("Text"),
     accessibilityIdentifier: "testTextField",
     formatter: BlocFormatter(format: { text in
         return text?.replacingOccurrences(of: "=)", with: "🙂")
     })
```
 */
public class BlocFormatter: Formatter {
    
    public var format: (String?) -> String?
    
    public init(format: @escaping (String?) -> String?) {
        self.format = format
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = format(string) as AnyObject
        return true
    }
    
}
