//
//  StandardTab.swift
//  AdmiralSwiftUI
//
//  Created on 19.04.2021.
//

import AdmiralTheme
import SwiftUI

/**
 StandardTab - A horizontal control that consists of multiple segments, each segment functioning as a discrete text button. The component is used to switch between two or three tabs. StandardTab is presented in two versions without additional indentation.

 You can create a StandardTab by specifying the following parameters in the initializer
 ## Initializer parameters:
- items - array of String. Each element of the array is a tab of Segment Control
- selection - Binding<Int>. Observable property for displaying the selected segment
 ## Example to create StandardTab:
 # Code
 ```
 @State private var isEnabledControlsState: Int = 0
 StandardTab(
            items: ["Default", "Disabled"],
            selection: $isEnabledControlsState)
 
 ```
*/
/// A horizontal control that consists of multiple segments, each segment functioning as a discrete text button.
@available(iOS 14.0, *)
public struct StandardTab: View {

    // MARK: - Constants

    enum Constants {
        static let segmentCornerRadius: CGFloat = LayoutGrid.module
        static let pickerPadding: CGFloat = LayoutGrid.halfModule
        static let segmentXPadding: CGFloat = LayoutGrid.doubleModule
        static let segmentYPadding: CGFloat = LayoutGrid.module
        static let activeSegmentLineWidth: CGFloat = LayoutGrid.halfModule / 2
        static let segmentLineWidth: CGFloat = 0.5
        static let segmentOffset: CGFloat = 3.0
        static let separatorWidth: CGFloat = 1.0
    }
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) var isEnabled

    // MARK: - Private Properties
    
    @Binding private var selection: Int
    @State private var tabSelection: Int = 0
    @State private var segmentSize: CGSize = .zero
    @State private var activeSegmentOffset: CGFloat = Constants.separatorWidth

    @Binding private var scheme: StandardTabScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<StandardTabScheme>()
    
    private let items: [String]
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with titles and binding selection.
    public init(
        items: [String],
        selection: Binding<Int>,
        scheme: Binding<StandardTabScheme?> = .constant(nil)
    ) {
        self._selection = selection
        self.items = items
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = scheme ?? schemeProvider.scheme
        ZStack(alignment: .leading) {
            GeometryReader { geo in
                HStack(spacing: 0.0) {
                    ForEach(0..<items.count, id: \.self) { index in
                        getSegmentView(for: index, width: geo.size.width)
                        if index != items.count - 1, items.count != 2 {
                            Rectangle()
                                .foregroundColor(scheme.borderColor.parameter(for: .normal)?.swiftUIColor ?? .clear)
                                .frame(width: Constants.separatorWidth)
                                .padding(.vertical, Constants.segmentYPadding)
                                .offset(x: -1.0)
                        }
                    }
                }
                .frame(height: LayoutGrid.quadrupleModule)
                .overlay(
                    RoundedRectangle(cornerRadius: LayoutGrid.module)
                        .stroke((isEnabled ? scheme.borderColor.parameter(for: .normal)?.swiftUIColor : scheme.borderColor.parameter(for: .disabled)?.swiftUIColor) ?? .clear, lineWidth: Constants.segmentLineWidth)
                )
                .padding(Constants.pickerPadding)
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: Constants.segmentCornerRadius))
                activeSegmentView(width: geo.size.width)
                    .onAppear {
                        tabSelection = selection
                        activeSegmentOffset = computeActiveSegmentHorizontalOffset(segmentWidth: geo.size.width)
                    }
                    .onChange(of: selection) { value in
                        tabSelection = value
                        withAnimation(.linear(duration: Durations.Default.half)) {
                            activeSegmentOffset = computeActiveSegmentHorizontalOffset(segmentWidth: geo.size.width)
                        }
                    }
            }
            .frame(height: LayoutGrid.quadrupleModule + Constants.activeSegmentLineWidth * 2)
        }
        .background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: Constants.segmentCornerRadius))
    }
    
    // MARK: - Private Methods
    
    private func activeSegmentView(width: CGFloat) -> AnyView {
        guard !items.isEmpty else { return EmptyView().eraseToAnyView() }
        
        let scheme = scheme ?? schemeProvider.scheme
        return
            RoundedRectangle(cornerRadius: Constants.segmentCornerRadius)
            .stroke((isEnabled ?
                        scheme.thumbColor.parameter(for: .normal)?.swiftUIColor
                        : scheme.thumbColor.parameter(for: .disabled)?.swiftUIColor) ?? .clear, lineWidth: 2)
            .foregroundColor(Color.clear)
            .frame(
                width: (width) / CGFloat(items.count) - Constants.activeSegmentLineWidth * 2,
                height: LayoutGrid.quadrupleModule)
            .offset(x: activeSegmentOffset, y: Constants.segmentOffset)
            .onAnimationCompleted(for: activeSegmentOffset) {
                selection = tabSelection
            }
            .eraseToAnyView()
        
    }
    
    private func computeActiveSegmentHorizontalOffset(segmentWidth: CGFloat) -> CGFloat {
        guard !items.isEmpty else { return 0.0 }
        
        var width: CGFloat = Constants.segmentOffset
        for _ in 0..<tabSelection {
            width += (segmentWidth / CGFloat(items.count))
            width -= Constants.activeSegmentLineWidth
        }
        return width
    }

    private func getSegmentView(for index: Int, width: CGFloat) -> some View {
        guard index < items.count else {
            return EmptyView().eraseToAnyView()
        }
        let scheme = scheme ?? schemeProvider.scheme
        let isSelected = tabSelection == index
        return Text(items[index])
            .foregroundColor(isEnabled ?
                             scheme.titleColor.parameter(for: .normal)?.swiftUIColor
                             : scheme.titleColor.parameter(for: .disabled)?.swiftUIColor)
            .font(isSelected ?
                  scheme.titleFont.parameter(for: .selected)?.swiftUIFont
                  : scheme.titleFont.parameter(for: .disabled)?.swiftUIFont)
            .lineLimit(1)
            .padding(.vertical, Constants.segmentYPadding)
            .frame(minWidth: 0, maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture { onItemTap(index: index, width: width) }
            .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
            .eraseToAnyView()
    }

    private func onItemTap(index: Int, width: CGFloat) {
        guard index < items.count else {
            return
        }
        tabSelection = index
        withAnimation(.linear(duration: Durations.Default.half)) {
            activeSegmentOffset = computeActiveSegmentHorizontalOffset(segmentWidth: width)
        }
    }
    
}

@available(iOS 14.0, *)
struct StandardTabPreviews: PreviewProvider {
    static var previews: some View {
        StandardTab(items: ["First", "Second"], selection: .constant(0))
    }
}
