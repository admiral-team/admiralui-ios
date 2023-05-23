//
//  ArrowListView.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ArrowListView - A view object with subtitle and title.
 
 ArrowListView has a public property:
 - state: ControlState - The state of the view. Default is normal.
 
 ## Example to create ArrowListView
 # Code
 ```
 ArrowListView()
```
 */
/// A view object with arrow image view.
@available(iOS 14.0.0, *)
public struct ArrowListView: View, TralingListViewComponent {
    
    private enum Constants {
        static let cellHeightThreshold: CGFloat = LayoutGrid.halfModule * 18
    }
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    /// The state of the view. Default is normal.
    @State var state: ControlState = .normal
    
    @ObservedObject private var schemeProvider: SchemeProvider<ArrowListViewScheme>
    
    // MARK: - Private Properties
    
    @State private var viewSize: CGSize = .zero

    private var alignment: VerticalAlignment {
        viewSize.height > Constants.cellHeightThreshold ? .top : .center
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(schemeProvider: SchemeProvider<ArrowListViewScheme> = AppThemeSchemeProvider<ArrowListViewScheme>()) {
        self.schemeProvider = schemeProvider
    }
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        VStack {
            if alignment == .center {
                Spacer(minLength: .zero)
            }
            HStack {
                Spacer()
                SymbolAssets.System.Outline.chevronRight.swiftUIImage
                    .frame(width: LayoutGrid.module, height: LayoutGrid.doubleModule)
                    .foregroundColor(isEnabled ? scheme.imageTintColor.parameter(for: .normal)?.swiftUIColor : scheme.imageTintColor.parameter(for: .disabled)?.swiftUIColor)
            }
            Spacer(minLength: .zero)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(SizeAwareViewModifier(viewSize: $viewSize))
    }
    
}

@available(iOS 14.0, *)
struct ArPreviews: PreviewProvider {
    
    static var previews: some View {
        ArrowListView().padding()
    }
    
}


