//
//  OutlineSliderTab.swift
//  AdmiralSwiftUI
//
//  Created on 22.04.2021.
//

import AdmiralTheme
import SwiftUI
/**
 OutlineSliderTab - A horizontal control with scroll that consists of multiple segments, each segment functioning as a discrete text button. Has a border along the contour of the view. The component is used to switch between multiple tabs. OutlineSliderTab is presented in one version with already planned margins - 16 pixels on the left and 8 pixels on top and bottom. You have the ability to enable and disable tabs, change the order of selected tabs.

 You can create a OutlineSliderTab by specifying the following parameters in the initialize:
 ## Initializer parameters:
 - items - array of String. Each element of the array is a tab of Segment Control
 - selection - Binding<Int>. Observable property for displaying the selected segment
 - offset - CGFloat. Horizontal offset from the left edge of the screen
 ## Example to create OutlineSliderTab:
 # Code
 ```
 @State private var isTwoItemControlsState: Int = 0
 OutlineSliderTab(
                items: ["One", "Two", "Three"],
                selection: $isTwoItemControlsState,
                offset: .constant(16.0))

 ```

 ## Initializer parameters:
 - items - array of OutlineSliderTabItem. Each element of the array is a tab of Segment Control with text and badge style.
 - selection - Binding<Int>. Observable property for displaying the selected segment
 - offset - CGFloat. Horizontal offset from the left edge of the screen
 ## Example to create OutlineSliderTab:
 # Code
 ```
 @State private var isTwoItemControlsState: Int = 0
 OutlineSliderTab(
                items: [OutlineSliderTabItem(title: "One", badgeStyle: .default), OutlineSliderTabItem(title: "Two", badgeStyle: nil)],
                selection: $isTwoItemControlsState,
                offset: .constant(16.0))

 ```
*/
/// A horizontal control with scroll that consists of multiple segments, each segment functioning as a discrete text button.
@available(iOS 14.0, *)
public struct OutlineSliderTab: View {

    enum Constants {
        static let segmentCornerRadius: CGFloat = 8.0
        static let animationDuration: Double = 0.1
        static let pickerPadding: CGFloat = 4
        static let segmentXPadding: CGFloat = 16
        static let segmentYPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 8.0
        static let lineWidth: CGFloat = 1.0
        static let selectedLineWidth: CGFloat = 2.0
        static let spacingElement: CGFloat = 8.0
        static let tabHeight: CGFloat = 32.0
    }

    // MARK: - Internal Properties

    @Environment(\.isEnabled) var isEnabled

    // MARK: - Public Properties

    /// Tap action.
    public var onTapAction: (() -> Void)? = nil

    // MARK: - Private Properties

    @Binding private var scheme: OutlineSliderTabScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<OutlineSliderTabScheme>()

    @Binding private var selection: Int
    @Binding private var offset: CGFloat

    private let items: [OutlineSliderTabItem]

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with titles.
    public init(
        items: [OutlineSliderTabItem],
        selection: Binding<Int>,
        offset: Binding<CGFloat> = .constant(0.0),
        onTapAction: (() -> Void)? = nil,
        scheme: Binding<OutlineSliderTabScheme?> = .constant(nil)
    ) {
        self._selection = selection
        self._offset = offset
        self.items = items
        self.onTapAction = onTapAction
        self._scheme = scheme
    }

    public init(
        items: [String],
        selection: Binding<Int>,
        offset: Binding<CGFloat> = .constant(0.0),
        onTapAction: (() -> Void)? = nil
    ) {
        self.init(
            items: items.map({ OutlineSliderTabItem(title: $0, badgeStyle: nil) }),
            selection: selection,
            offset: offset,
            onTapAction: onTapAction)
    }

    // MARK: - Body

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0.0) {
                Spacer().frame(width: offset + Constants.selectedLineWidth, height: Constants.tabHeight)
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.getSegmentView(for: index)
                        .frame(height: LayoutGrid.quadrupleModule - Constants.selectedLineWidth)
                    if index != items.count - 1 {
                        Spacer()
                            .frame(width: Constants.spacingElement, height: Constants.tabHeight)
                    } else {
                        Spacer()
                            .frame(width: offset, height: Constants.tabHeight)
                    }
                }
            }
            .frame(height: Constants.tabHeight + Constants.selectedLineWidth * 2)
        }
        .frame(height: Constants.tabHeight + Constants.selectedLineWidth * 2)
    }

    // MARK: - Private Methods

    private func getSegmentView(for index: Int) -> some View {
        let scheme = scheme ?? schemeProvider.scheme

        guard index < items.count else {
            return EmptyView().eraseToAnyView()
        }

        let isSelected = selection == index
        var strokeColor = scheme.borderColor.parameter(for: .normal)
        if isSelected {
            strokeColor = isEnabled ? scheme.thumbColor.parameter(for: .selected) : scheme.thumbColor.parameter(for: .disabled)
        } else {
            strokeColor = isEnabled ? scheme.borderColor.parameter(for: .normal) : scheme.borderColor.parameter(for: .disabled)
        }
        return roundView(scheme: scheme, isSelected: isSelected, strokeColor: strokeColor?.swiftUIColor, index: index)            .eraseToAnyView()
    }

    @ViewBuilder
    private func roundView(scheme: OutlineSliderTabScheme, isSelected: Bool, strokeColor: Color?, index: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(strokeColor ?? .clear, lineWidth: isSelected ? Constants.selectedLineWidth : Constants.lineWidth)
            if let badgeStyle = items[index].badgeStyle {
                BadgeView(
                    badgeStyle: badgeStyle,
                    text: nil,
                    borderColor: scheme.backgroundColor.swiftUIColor,
                    offset: CGPoint(x: -LayoutGrid.halfModule, y: LayoutGrid.module)) {
                    textView(scheme: scheme, isSelected: isSelected, index: index)
                }
                .padding(.horizontal, LayoutGrid.halfModule)
            }
            else {
                textView(scheme: scheme, isSelected: isSelected, index: index)
            }

        }
        .onTapGesture { self.onItemTap(index: index) }
    }

    @ViewBuilder
    private func textView(scheme: OutlineSliderTabScheme, isSelected: Bool, index: Int) -> some View {
        Text(self.items[index].title)
            .foregroundColor(isEnabled ?
                             scheme.titleColor.parameter(for: .normal)?.swiftUIColor : scheme.titleColor.parameter(for: .disabled)?.swiftUIColor)
            .font(isSelected ?
                  scheme.titleFont.parameter(for: .selected)?.swiftUIFont : scheme.titleFont.parameter(for: .disabled)?.swiftUIFont)
            .lineLimit(1)
            .padding(.vertical, Constants.segmentYPadding)
            .padding(.horizontal, Constants.segmentXPadding)
    }

    private func onItemTap(index: Int) {
        guard index < self.items.count else {
            return
        }
        self.selection = index
        onTapAction?()
    }

}
