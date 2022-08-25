//
//  InformerTab.swift
//  AdmiralSwiftUI
//
//  Created on 27.04.2021.
//

import AdmiralTheme
import SwiftUI

public struct InformerSegmentedItem {
    var title: String
    var subtitle: String
    
    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

/**
 InformerTab - A horizontal control that consists of multiple segments with custom view, each segment functioning as a discrete text button. The component is used to switch between two or three tabs. Custom View has - an expanded informer component, the position of which under InformerTab.

 You can create a InformerTab by specifying the following parameters in the initializer
 ## Initializer parameters:
 - items - array of InformerSegmentedItem. InformerSegmentedItem - a struct with title and subtitle
 - selection - Binding<Int>. Observable property for displaying the selected segment
 - customView - AnyView located under InformerTab
 - offsetSegment - horizontal offset from the edges of the screen (CGFloat)
 ## Example to create InformerTab:
 # Code
 ```
 @State private var isThreeItemControlsState: Int = 0
 InformerTab(
            items: [InformerSegmentedItem(title: "2 900 ₽",
                                        subtitle: "в месяц"),
                    InformerSegmentedItem(title: "2 900 ₽",
                                        subtitle: "в месяц"),],
                          customView: AnyView("Your View"),
                          selection: $isThreeItemControlsState,
                          offsetSegment: .constant(16.0))
 
 ```
*/
/// A horizontal control that consists of multiple segments, each segment functioning as a discrete text button.
@available(iOS 14.0, *)
public struct InformerTab: View {
    
    enum Constants {
        static let segmentCornerRadius: CGFloat = 8.0
        static let animationDuration: Double = 0.1
        static let pickerPadding: CGFloat = 4
        static let segmentXPadding: CGFloat = 16
        static let segmentYPadding: CGFloat = 8
        static let segmentHeight: CGFloat = 80.0
        static let lineWidth: CGFloat = 1.0
        static let selectedLineWidth: CGFloat = 2.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    // MARK: - Private Properties
    
    @State private var segmentSize: CGSize = .zero
    @State private var arrowOffset: CGFloat = .zero
    @State private var scheme: InformerTabScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<InformerTabScheme>()
        
    @Binding private var selection: Int
    @Binding private var offsetSegment: CGFloat

    private var activeSegmentView: AnyView {
        let scheme = self.scheme ?? schemeProvider.scheme
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        return
            RoundedRectangle(cornerRadius: Constants.segmentCornerRadius)
            .stroke((isEnabled ?
                        scheme.thumbColor.parameter(for: .normal)?.swiftUIColor : scheme.thumbColor.parameter(for: .disabled)?.swiftUIColor) ?? .clear, lineWidth: 2)
            .foregroundColor(Color.clear)
            .frame(width: segmentSize.width, height: Constants.segmentHeight)
            .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
            .animation(Animation.linear(duration: Constants.animationDuration))
            .eraseToAnyView()
        
    }
    
    private var arrowSegmentSlider: AnyView {
        return
            ArrowSegmentSlider()
            .offset(x: computeActiveSegmentHorizontalOffset() + segmentSize.width / 2 - ArrowSegmentSlider.Constants.imageSize.width / 2, y: 0)
            .eraseToAnyView()
    }
    
    private var customView: AnyView
    private let items: [InformerSegmentedItem]
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object.
    public init(
        items: [InformerSegmentedItem],
        customView: AnyView = AnyView(EmptyView()),
        selection: Binding<Int> = .constant(0),
        offsetSegment: Binding<CGFloat> = .constant(0.0)) {
        self._selection = selection
        self._offsetSegment = offsetSegment
        self.customView = customView
        self.items = items
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            ZStack(alignment: .leading) {
                HStack(spacing: LayoutGrid.module) {
                    ForEach(0..<self.items.count, id: \.self) { index in
                        self.getSegmentView(for: index)
                    }
                }
                .frame(height: Constants.segmentHeight)
                .padding(.horizontal, offsetSegment)
            }
            Spacer()
                .frame(height: LayoutGrid.halfModule)
            arrowSegmentSlider
                .offset(y: LayoutGrid.halfModule / 2)
                .padding(.horizontal, offsetSegment)
            customView
        }

    }
    
    // MARK: - Private Methods

    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        var width: CGFloat = 0
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
        let isSelected = selection == index
        var strokeColor = scheme.borderColor.parameter(for: .normal)
        if isSelected {
            strokeColor = isEnabled ? scheme.thumbColor.parameter(for: .selected) : scheme.thumbColor.parameter(for: .disabled)
        } else {
            strokeColor = isEnabled ? scheme.borderColor.parameter(for: .normal) : scheme.borderColor.parameter(for: .disabled)        }
        return
            VStack(spacing: 8.0) {
                Text(items[index].title)
                .foregroundColor(isEnabled ?
                                    scheme.titleColor.parameter(for: .normal)?.swiftUIColor : scheme.titleColor.parameter(for: .disabled)?.swiftUIColor)
                .font(isSelected ?
                        scheme.titleFont.parameter(for: .selected)?.swiftUIFont : scheme.titleFont.parameter(for: .disabled)?.swiftUIFont)
                .lineLimit(1)
                
                Text(items[index].subtitle)
                .foregroundColor(isEnabled ?
                                    scheme.subtitleColor.parameter(for: .normal)?.swiftUIColor : scheme.subtitleColor.parameter(for: .disabled)?.swiftUIColor)
                .font(isSelected ?
                        scheme.subtitleFont.parameter(for: .selected)?.swiftUIFont : scheme.subtitleFont.parameter(for: .disabled)?.swiftUIFont)
                .lineLimit(1)
            }
            .padding(.vertical, Constants.segmentYPadding)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: Constants.segmentHeight)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(strokeColor?.swiftUIColor ?? .clear, lineWidth: isSelected ? Constants.selectedLineWidth : Constants.lineWidth)
            )
            .contentShape(Rectangle())
            .onTapGesture { onItemTap(index: index) }
            .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
            .eraseToAnyView()
    }

    private func onItemTap(index: Int) {
        guard index < items.count else {
            return
        }
        self.selection = index
    }
    
}

