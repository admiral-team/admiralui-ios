//
//  ListCell.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme

/**
 ListViewCell - The protocol with properties and methods for list cell.
 
 Public protocol properties:

 - isHighlighted: Bool? { get set } - A Boolean value indicating whether the view is in the highlighted state.
 
 */
/// The protocol with properties and methods for list cell.
@available(iOS 14.0.0, *)
public protocol ListViewCell: View {
    
    /// A Boolean value indicating whether the view is in the highlighted state.
    var isHighlighted: Bool? { get set }
}

/// The enum that discribes a corner radius thats multiple of four.
public enum CornerRadius: CGFloat {
    /// The zero value of corner radius.
    case zero = 0
    /// The module value of corner radius.
    case module = 4
    /// The doubleModule value of corner radius.
    case doubleModule = 8
    /// The tripleModule value of corner radius.
    case tripleModule = 12
    /// The quadrupleModule value of corner radius.
    case quadrupleModule = 16
}
/**
 ListCell - A view that displays leading, trailing and image views.
 
 You can create a ListCell with a zero-frame rectangle using one of the two initializers:

 First init:
 - leadingView:: (() -> C)? - leading view.
 - centerView: (() -> T)? - center view.
 - trailingView: (() -> L)? - trailing view.
 - centerLayoutPriority - Center layout priority.
 - trailingLayoutPriority - Trailing layout priority.
 
 Secont init (without propertys):
 - Create ListCell without leadingView, centerView, trailingView
 
 You can also create a ListCell with a specific parameter by specifying the parameter type as generic ListCell

 ##  Example of creating ListCell only with centerView
 # Code
 ```
 ListCell<EmptyView, SubtitleTitleListView, EmptyView>(
     centerView: {
         SubtitleTitleListView(
             title: "Title",
             subtitle: "Subtitle"
         )
     }
 )
```
 */
/// A view that displays leading, trailing and image views.
@available(iOS 14.0.0, *)
public struct ListCell<L, C, T>: ListViewCell where L: View , C: View, T: View {

    /// A Boolean value indicating whether the view is in the highlighted state.
    @Binding public var isHighlighted: Bool?
    
    /// A Boolean value indicating whether the view is in the selected state.
    @Binding public var isSelected: Bool?
    
    /// Center view.
    public var centerView: (() -> C)?
    
    /// trailing view.
    public var trailingView: (() -> T)?
    
    /// Leading view.
    public var leadingView: (() -> L)?
    
    // MARK: Internal Properties
    
    @State var minHeight = LayoutGrid.halfModule * 18
    @State var edgeInsets = EdgeInsets(
        top: LayoutGrid.halfModule * 3,
        leading: LayoutGrid.doubleModule,
        bottom: LayoutGrid.halfModule * 3,
        trailing: LayoutGrid.doubleModule)
    @State var leadingViewWidth: CGFloat = LayoutGrid.halfModule * 14

    @State var segmentSize: CGSize = .zero
    
    // MARK: - Private Properties
    
    private var cornerRadius: CGFloat = 0.0
    private var centerLayoutPriority: Double = 1.0
    private var trailingLayoutPriority: Double = 0.0
    
    private var isCenterFixedSize: Bool {
        return centerLayoutPriority == 0
    }
    private var isTrailingFixedSize: Bool {
        return trailingLayoutPriority == 0
    }
    
    @State private var scheme: ListCellScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<ListCellScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - leadingView: leading view.
    ///   - centerView: center view.
    ///   - trailingView: trailing view.
    ///   - centerLayoutPriority: Center layout priority.
    ///   - trailingLayoutPriority: Trailing layout priority.
    ///   - cornerRadius: Rorner radius cell.
    public init(
        @ViewBuilder leadingView: @escaping () -> L,
        @ViewBuilder centerView: @escaping () -> C,
        @ViewBuilder trailingView: @escaping () -> T,
        isHighlighted: Binding<Bool?> = .constant(nil),
        isSelected: Binding<Bool?> = .constant(nil),
        centerLayoutPriority: Double = 1.0,
        trailingLayoutPriority: Double = 0.0,
        cornerRadius: CornerRadius = .zero) {
            self.centerView = centerView
            self.trailingView = trailingView
            self.leadingView = leadingView
            self._isHighlighted = isHighlighted
            self._isSelected = isSelected
            self.centerLayoutPriority = centerLayoutPriority
            self.trailingLayoutPriority = trailingLayoutPriority
            self.cornerRadius = cornerRadius.rawValue
        }
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - leadingView: leading view.
    ///   - centerView: center view.
    ///   - trailingView: trailing view.
    ///   - centerLayoutPriority: Center layout priority.
    ///   - trailingLayoutPriority: Trailing layout priority.
    ///   - cornerRadius: Rorner radius cell.
    public init(
        leadingView: (() -> L)? = nil,
        centerView: (() -> C)? = nil,
        trailingView: (() -> T)? = nil,
        isHighlighted: Binding<Bool?> = .constant(nil),
        isSelected: Binding<Bool?> = .constant(nil),
        centerLayoutPriority: Double = 1.0,
        trailingLayoutPriority: Double = 0.0,
        cornerRadius: CornerRadius = .zero) {
            self.centerView = centerView
            self.trailingView = trailingView
            self.leadingView = leadingView
            self._isHighlighted = isHighlighted
            self._isSelected = isSelected
            self.centerLayoutPriority = centerLayoutPriority
            self.trailingLayoutPriority = trailingLayoutPriority
            self.cornerRadius = cornerRadius.rawValue
        }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        if isSelected != nil {
            contentView(scheme: scheme)
                .frame(minHeight: minHeight)
            .onTapGesture {
                self.isSelected?.toggle()
            }
        } else {
            contentView(scheme: scheme)
                .frame(minHeight: minHeight)
        }
    }
    
    // MARK: - Public Methods
    
    /// Set minimum height and insets for cell.
    /// - Parameter minHeight: Min height.
    /// - Parameter edgeInsets: insets.
    /// - Returns: view.
    public func configCell(
        minHeight: CGFloat = LayoutGrid.halfModule * 18,
        edgeInsets: EdgeInsets = EdgeInsets(
            top: LayoutGrid.halfModule * 3,
            leading: LayoutGrid.doubleModule,
            bottom: LayoutGrid.halfModule * 3,
            trailing: LayoutGrid.doubleModule),
        leadingViewWidth: CGFloat = LayoutGrid.halfModule * 14) -> some View {
        var view = self
        view._minHeight = State(initialValue: minHeight)
        view._edgeInsets = State(initialValue: edgeInsets)
        view._leadingViewWidth = State(initialValue: leadingViewWidth)
        return view.id(UUID())
    }
    
    // MARK: - Private Methods
    
    private func contentView(scheme: ListCellScheme) -> some View {
        return ZStack {
            if let isSelected = isSelected {
                scheme.backgroundColor.parameter(for: isSelected ? .highlighted : .normal)?.swiftUIColor
            } else if let isHighlighted = isHighlighted {
                scheme.backgroundColor.parameter(for: isHighlighted ? .highlighted : .normal)?.swiftUIColor
            } else {
                scheme.backgroundColor.parameter(for: .normal)?.swiftUIColor
            }
            HStack(alignment: .center, spacing: LayoutGrid.module) {
                if let leadingAccessoryView = leadingView {
                    if segmentSize.height > minHeight {
                        VStack(alignment: .center) {
                            leadingAccessoryView()
                            Spacer()
                        }
                        .frame(width: leadingViewWidth)
                    } else {
                        VStack(alignment: .center, spacing: 0.0) {
                            Spacer()
                            leadingAccessoryView()
                            Spacer()
                        }
                        .frame(width: leadingViewWidth)
                        .frame(height: minHeight)
                    }
                }
                if let centerView = centerView {
                    centerView()
                        .layoutPriority(centerLayoutPriority)
                        .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
                }
                if let trailingView = trailingView {
                    Spacer()
                    trailingView()
                        .layoutPriority(trailingLayoutPriority)
                }

            }
            .padding(edgeInsets)
        }
        .cornerRadius(cornerRadius)
    }
    
}

@available(iOS 14.0, *)
extension ListCell where L == EmptyView {
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - centerView: center view.
    ///   - trailingView: trailing view.
    ///   - centerLayoutPriority: Center layout priority.
    ///   - trailingLayoutPriority: Trailing layout priority.
    ///   - cornerRadius: Rorner radius cell.
    public init(
        @ViewBuilder centerView: @escaping () -> C,
        @ViewBuilder trailingView: @escaping () -> T,
        isHighlighted: Binding<Bool?> = .constant(nil),
        isSelected: Binding<Bool?> = .constant(nil),
        centerLayoutPriority: Double = 1.0,
        trailingLayoutPriority: Double = 0.0,
        cornerRadius: CornerRadius = .zero) {
            self.init(
                leadingView: nil,
                centerView: centerView,
                trailingView: trailingView,
                isHighlighted: isHighlighted,
                isSelected: isSelected,
                centerLayoutPriority: centerLayoutPriority,
                trailingLayoutPriority: trailingLayoutPriority,
                cornerRadius: cornerRadius)
        }
    
}

@available(iOS 14.0, *)
extension ListCell where T == EmptyView {
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - leadingView: leading view.
    ///   - centerView: center view.
    ///   - centerLayoutPriority: Center layout priority.
    ///   - trailingLayoutPriority: Trailing layout priority.
    ///   - cornerRadius: Rorner radius cell.
    public init(
        @ViewBuilder leadingView: @escaping () -> L,
        @ViewBuilder centerView: @escaping () -> C,
        isHighlighted: Binding<Bool?> = .constant(nil),
        isSelected: Binding<Bool?> = .constant(nil),
        centerLayoutPriority: Double = 1.0,
        trailingLayoutPriority: Double = 0.0,
        cornerRadius: CornerRadius = .zero) {
            self.init(
                leadingView: leadingView,
                centerView: centerView,
                trailingView: nil,
                isHighlighted: isHighlighted,
                isSelected: isSelected,
                centerLayoutPriority: centerLayoutPriority,
                trailingLayoutPriority: trailingLayoutPriority,
                cornerRadius: cornerRadius)
        }
    
}

@available(iOS 14.0, *)
extension ListCell where L == EmptyView, T == EmptyView {
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - centerView: center view.
    ///   - centerLayoutPriority: Center layout priority.
    ///   - trailingLayoutPriority: Trailing layout priority.
    ///   - cornerRadius: Rorner radius cell.
    public init(
        @ViewBuilder centerView: @escaping () -> C,
        isHighlighted: Binding<Bool?> = .constant(nil),
        isSelected: Binding<Bool?> = .constant(nil),
        centerLayoutPriority: Double = 1.0,
        trailingLayoutPriority: Double = 0.0,
        cornerRadius: CornerRadius = .zero) {
            self.init(
                leadingView: nil,
                centerView: centerView,
                trailingView: nil,
                isHighlighted: isHighlighted,
                isSelected: isSelected,
                centerLayoutPriority: centerLayoutPriority,
                trailingLayoutPriority: trailingLayoutPriority,
                cornerRadius: cornerRadius)
        }
    
}

@available(iOS 14.0, *)
struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell<EmptyView, SubtitleTitleListView, EmptyView>(
            centerView: {
                SubtitleTitleListView(
                    title: "Title",
                    subtitle: "Subtitle"
                )
            }
        )
    }
}
