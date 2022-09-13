//
//  DatePercentListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 DatePercentListView - A view object with date and percent label.
 
 You can create a DatePercentListView with the zero frame rectangle by specifying the following parameters in init:
 - date: String - The text that the date label displays.
 - percent: String - The text that the percent label displays.
 
 DatePercentListView has a public property:
 - isHighlighted: Bool - A Boolean value indicating whether the view is in the highlighted state.
 - isHighlightedEnabled: Bool - A Boolean value indicating whether the view can  draws a highlight.
 
 ## Example to create DatePercentListView
 # Code
 ```
 DatePercentListView(date: "Date", percent: "Text")
```
 */
/// A view object with date and percent label.
@available(iOS 14.0, *)
public struct DatePercentListView: View, TralingListViewComponent {
    
    // MARK: - Public Properties
    
    /// The text that the date label displays.
    @Binding var date: String?
    
    /// The text that the percent label displays.
    @Binding var percent: String?
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    @State private var scheme: DatePercentListViewScheme? = nil
    @ObservedObject private var schemeProvider: SchemeProvider<DatePercentListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        date: String?,
        percent: String?,
        schemeProvider: SchemeProvider<DatePercentListViewScheme> = AppThemeSchemeProvider<DatePercentListViewScheme>()
    ) {
        self._date = Binding(get: { return date }, set: { _ in })
        self._percent = Binding(get: { return percent }, set: { _ in })
        self.schemeProvider = schemeProvider
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        HStack(alignment: .center) {
            Spacer()
            VStack(spacing: LayoutGrid.module) {
                if let date = date {
                    Text(date)
                        .foregroundColor(scheme.titleColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                        .font(scheme.titleFont.swiftUIFont)
                }
                if let percent = percent {
                    Text(percent)
                        .foregroundColor(scheme.subtitleColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                        .font(scheme.subtitleFont.swiftUIFont)
                }
            }
        }
        .frame(width: 96.0, height: 48.0)
    }
    
}


