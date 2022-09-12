//
//  LogoTab.swift
//  AdmiralUIResources
//
//  Created on 21.04.2021.
//

import AdmiralTheme
import SwiftUI

/**
 LogoTab - A horizontal control that consists of multiple segments, each segment functioning as a discrete image button. The component is used to switch between two or three tabs. It is presented in two versions without additional indentation.

 You can create a LogoTab by specifying the following parameters in the initializer
 ## Initializer parameters:
- images - array of Image. Each element of the array is a tab of Segment Control
- selection - Binding<Int>. Observable property for displaying the selected segment
 ## Example to create LogoTab:
 # Code
 ```
 @State private var isEnabledControlsState: Int = 0
 StandardTab(
            images: [Image("YourImage_1"), "Image("YourImage_2")"],
            selection: $isEnabledControlsState)
 
 ```
*/
@available(iOS 14.0, *)
/// A horizontal control that consists of multiple segments, each segment functioning as a discrete image button.
public struct LogoTab: View {
    
    enum Constants {
        static let segmentCornerRadius: CGFloat = LayoutGrid.module
        static let pickerPadding: CGFloat = LayoutGrid.halfModule
        static let segmentXPadding: CGFloat = LayoutGrid.doubleModule
        static let segmentYPadding: CGFloat = LayoutGrid.module
        static let height: CGFloat = LayoutGrid.doubleModule * 3
        static let activeSegmentLineWidth: CGFloat = LayoutGrid.halfModule / 2
        static let segmentLineWidth: CGFloat = 0.5
        static let segmentOffset: CGFloat = 3.0
    }
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    // MARK: - Private Properties
    
    @Binding private var selection: Int
    
    @State private var segmentSize: CGSize = .zero
    @State private var scheme: LogoTabScheme? = nil
    @State private var items: [Image] = []
    @ObservedObject private var schemeProvider: SchemeProvider<LogoTabScheme>
    
    private var activeSegmentView: AnyView {
        let scheme = self.scheme ?? schemeProvider.scheme
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        return
            RoundedRectangle(cornerRadius: Constants.segmentCornerRadius)
            .stroke((isEnabled ?
                        scheme.thumbColor.parameter(for: .normal)?.swiftUIColor : scheme.thumbColor.parameter(for: .disabled)?.swiftUIColor) ?? .clear, lineWidth: Constants.activeSegmentLineWidth)
            .foregroundColor(Color.clear)
            .frame(width: segmentSize.width, height: Constants.height)
            .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
            .animation(Animation.linear(duration: Durations.Default.half))
            .eraseToAnyView()
        
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with images and binding selection.
    public init(
        images: [Image],
        selection: Binding<Int>,
        schemeProvider: SchemeProvider<LogoTabScheme> = AppThemeSchemeProvider<LogoTabScheme>()
    ) {
        self._selection = selection
        self._items = .init(initialValue: images)
        self.schemeProvider = schemeProvider
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        ZStack(alignment: .leading) {
            HStack(spacing: 0.0) {
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.getSegmentView(for: index)
                    if index != self.items.count - 1, items.count != 2 {
                        Rectangle()
                            .foregroundColor(scheme.borderColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear)
                            .frame(width: 1.0)
                            .padding(.vertical, Constants.segmentYPadding)
                            .offset(x: -LayoutGrid.halfModule / 2)
                    }
                }
            }
            .frame(height: Constants.height)
            .overlay(
                RoundedRectangle(cornerRadius: LayoutGrid.module)
                    .stroke(scheme.borderColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor ?? .clear, lineWidth: Constants.segmentLineWidth)
            )
            .padding(Constants.pickerPadding)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: Constants.segmentCornerRadius))
            self.activeSegmentView
        }

    }
    
    // MARK: - Private Methods

    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        var width: CGFloat = Constants.segmentOffset
        for _ in 0..<selection {
            width += segmentSize.width
        }
        return width
    }

    private func getSegmentView(for index: Int) -> some View {
        let scheme = scheme ?? schemeProvider.scheme
        guard index < items.count else {
            return EmptyView().eraseToAnyView()
        }
        return
            self.items[index]
            .opacity((isEnabled ? scheme.alphaLogo.parameter(for: .normal) : scheme.alphaLogo.parameter(for: .disabled)) ?? 1.0)
            .padding(.vertical, Constants.segmentYPadding)
            .frame(minWidth: 0, maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture { onItemTap(index: index) }
            .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
            .eraseToAnyView()
    }

    private func onItemTap(index: Int) {
        guard index < items.count else {
            return
        }
        selection = index
    }
    
}

