//
//  UnderlineTab.swift
//  AdmiralSwiftUI
//
//  Created on 23.04.2021.
//

import AdmiralTheme
import SwiftUI

/**
 UnderlineTab - A horizontal control with scroll that consists of multiple segments, each segment functioning as a discrete text button. Has a line under view. The component is used to switch between multiple tabs. UnderlineTab is presented in one version with already planned margins - 16px on the left, 22px on top and 14px on the bottom. You have the ability to enable and disable tabs, change the order of the selected tab.
 
 You can create a UnderlineTab by specifying the following parameters in the initializer:
 ## Initializer parameters:
 - items - array of String. Each element of the array is a tab of Segment Control
 - selection - Binding<Int>. Observable property for displaying the selected segment
 - offset - CGFloat. Horizontal offset from the left edge of the screen
 - isScrollEnabled - Bool. The state that allows to scroll content in disable mode.
 ## Example to create UnderlineTab:
 # Code
 ```
 @State private var isTwoItemControlsState: Int = 0
 UnderlineTab(
 items: ["One", "Two", "Three"],
 selection: $isTwoItemControlsState,
 offset: .constant(16.0))
 
 ```
 
 ## Initializer parameters:
 - items - array of UnderlineTabItem. Each element of the array is a tab of Segment Control with title and badge style.
 - selection - Binding<Int>. Observable property for displaying the selected segment
 - offset - CGFloat. Horizontal offset from the left edge of the screen
 - isScrollEnabled - Bool. The state that allows to scroll content in disable mode.
 ## Example to create UnderlineTab:
 # Code
 ```
 @State private var isTwoItemControlsState: Int = 0
 UnderlineTab(
 items: ["One", "Two", "Three"],
 selection: $isTwoItemControlsState,
 offset: .constant(16.0))
 
 ```
 */
/// A horizontal control with scroll that consists of multiple segments, each segment functioning as a discrete text button.
@available(iOS 14.0, *)
public struct UnderlineTab: View {
    
    // MARK: - Contstnats
    
    enum Constants {
        static let segmentCornerRadius: CGFloat = LayoutGrid.module
        static let pickerPadding: CGFloat = LayoutGrid.halfModule
        static let segmentXPadding: CGFloat = LayoutGrid.module
        static let segmentBadgeXPadding: CGFloat = LayoutGrid.doubleModule
        static let segmentYPadding: CGFloat = LayoutGrid.module
        static let tabHeight: CGFloat = LayoutGrid.quadrupleModule
        static let spacingElement: CGFloat = LayoutGrid.module
    }
    
    // MARK: - Internal Propeties
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Private Propeties
    
    @Binding private var selection: Int
    @Binding private var offset: CGFloat
    @Binding private var isStaticTabs: Bool
    
    @State private var segmentSize: CGSize = .zero
    @State private var segmentRect: CGRect = .zero
    @State private var activeSegmentRect: CGRect = .zero
    @State private var scrollViewSegmentRect: CGRect = .zero
    @State private var activeSegmentX: CGFloat = 0
    @State private var isShowStartPositionActiveSegment: Bool = false
    
    @State private var scheme: UnderlineTabScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<UnderlineTabScheme>()
    
    private var activeSegmentView: AnyView {
        let scheme = self.scheme ?? schemeProvider.scheme
        let backgroundColor: Color = ( isEnabled ? scheme.thumbColor.parameter(for: .normal)?.swiftUIColor : scheme.thumbColor.parameter(for: .disabled)?.swiftUIColor) ?? .clear
        
        return RoundedRectangle(cornerRadius: LayoutGrid.halfModule / 4)
            .foregroundColor(backgroundColor)
            .frame(width: segmentRect.size.width, height: LayoutGrid.halfModule / 2)
            .offset(x: activeSegmentX, y: LayoutGrid.doubleModule)
            .modifier(RectAwareViewModifier(viewRect: $activeSegmentRect))
            .eraseToAnyView()
    }
    
    private let items: [UnderlineTabItem]
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with items.
    public init(
        items: [UnderlineTabItem],
        selection: Binding<Int>,
        offset: Binding<CGFloat> = .constant(0.0),
        isStaticTabs: Binding<Bool> = .constant(false)
    ) {
        self._selection = selection
        self._offset = offset
        self.items = items
        self._isStaticTabs = isStaticTabs
    }
    
    /// Initializes and returns a newly allocated view object with items.
    public init(
        items: [String],
        selection: Binding<Int>,
        offset: Binding<CGFloat> = .constant(0.0),
        isStaticTabs: Binding<Bool> = .constant(false)
    ) {
        self.init(items: items.map({ UnderlineTabItem(title: $0, badgeStyle: nil) }), selection: selection, offset: offset, isStaticTabs: isStaticTabs)
    }
    
    public var body: some View {
        if isStaticTabs {
            content()
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                content()
            }
        }
    }
    
    // MARK: - Private Methods
    
    @ViewBuilder
    private func content() -> some View {
        ZStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline, spacing: .zero) {
                if offset > 0 {
                    offsetView()
                }
                ForEach(0..<items.count, id: \.self) { index in
                    getSegmentView(for: index)
                }
                if offset > 0 {
                    offsetView()
                }
            }
            .frame(height: Constants.tabHeight)
            .padding(.vertical, Constants.segmentYPadding)
            activeSegmentView
        }
        .edgesIgnoringSafeArea(.all)
        .frame(height: Constants.tabHeight)
        .modifier(RectAwareViewModifier(viewRect: $scrollViewSegmentRect))
        .onChange(of: scrollViewSegmentRect) { rect in
            guard !isShowStartPositionActiveSegment,
                  activeSegmentRect.width > 0 else { return }
            
            isShowStartPositionActiveSegment = true
            setActiveSegmentX()
        }
    }
    
    @ViewBuilder
    private func offsetView() -> some View {
        Spacer()
            .frame(width: offset, height: Constants.tabHeight)
    }
    
    private func getSegmentView(for index: Int) -> some View {
        let scheme = scheme ?? schemeProvider.scheme
        
        guard index < items.count else {
            return EmptyView().eraseToAnyView()
        }
        let isSelected = selection == index
        if let badgeStyle = items[index].badgeStyle {
            return BadgeView(
                badgeStyle: badgeStyle,
                text: nil,
                borderColor: scheme.backgroundColor.swiftUIColor,
                offset: CGPoint(x: -LayoutGrid.halfModule, y: LayoutGrid.module)) {
                    textView(scheme: scheme, withBadgeStyle: true, isSelected: isSelected, index: index)
                }
                .padding(.horizontal, LayoutGrid.module)
                .eraseToAnyView()
        }
        else {
            return textView(scheme: scheme, withBadgeStyle: false, isSelected: isSelected, index: index).eraseToAnyView()
        }
    }
    
    @ViewBuilder
    private func textView(scheme: UnderlineTabScheme, withBadgeStyle: Bool, isSelected: Bool, index: Int) -> some View {
        Text(self.items[index].title)
            .foregroundColor(isEnabled  ?
                             scheme.titleColor.parameter(for: .normal)?.swiftUIColor : scheme.titleColor.parameter(for: .disabled)?.swiftUIColor)
            .font(isSelected ?
                  scheme.titleFont.parameter(for: .selected)?.swiftUIFont : scheme.titleFont.parameter(for: .disabled)?.swiftUIFont)
            .lineLimit(1)
            .padding(.vertical, Constants.segmentYPadding)
            .padding(.horizontal, withBadgeStyle ? Constants.segmentBadgeXPadding : Constants.segmentXPadding)
            .frame(minWidth: 0, maxWidth: isStaticTabs ? .infinity : nil)
            .onTapGesture { onItemTap(index: index) }
            .modifier(RectAwareViewModifier(viewRect: isSelected ? self.$segmentRect : .constant(.zero)))
            .onChange(of: segmentRect, perform: { newValue in
                withAnimation(.linear(duration: Durations.Default.half)) {
                    setActiveSegmentX()
                }
            })
            .onChange(of: selection, perform: { newValue in
                withAnimation(.linear(duration: Durations.Default.half)) {
                    setActiveSegmentX()
                }
            })
    }
    
    private func setActiveSegmentX() {
        activeSegmentX = segmentRect.origin.x - scrollViewSegmentRect.origin.x
    }
    
    private func onItemTap(index: Int) {
        guard index < items.count else { return }
        
        selection = index
    }
    
}

@available(iOS 14.0, *)
struct UnderlineTabPreviews: PreviewProvider {
    
    static var previews: some View {
        UnderlineTab(items: ["First", "Second"], selection: .constant(0))
    }
}
