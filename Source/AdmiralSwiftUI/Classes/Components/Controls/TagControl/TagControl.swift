//
//  TagControl.swift
//  AdmiralSwiftUI
//
//  Created on 29.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

public enum TagStyle: Int {
    case none
    case `default`
    case success
    case additional
    case error
    case attention
}

/**
 A TagControl is a label that marks and catalogs information to facilitate the search process. When you click on a tag, all elements with this tag are loaded.

 ## To create a TagControl, you can use four initializers:
 - without leadingView or trailingView
- with leadingView
- with trailingView
- with leadingView and with trailingView
 
 ## TagControl also has six display styles:
- empty style
- default
- success
- additional
- error
- attention
 ## Example to create TagControl:
 # Code
 ```
 TagControl(title: "Title",
            tagStyle: .attention,
            leadingView: {
                         Image(uiImage: "Your image")
                         },
            tapTagControl: {})
 ```
*/
@available(iOS 14.0, *)
public struct TagControl: View {

    // MARK: - Public Properties
    
    /// Tap tag control.
    public var tapTagControl: () -> ()
    
    /// Tag style.
    public var tagStyle: TagStyle
    
    /// Additional leading view. In this field, you can add any object from UIView.
    public var leadingView: (() -> AnyView)?
    
    /// Additional trailing view. In this field, you can add any object from UIView.
    public var trailingView: (() -> AnyView)?
    
    /// The text in the middle.
    public var title: String?
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    @State var isPressing: Bool = false
    
    
    // MARK: - Private Properties
    
    @State private var scheme: TagControlScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<TagControlScheme>()

    // MARK: - Private Parameters
    
    // MARK: - Initializer
    
    public init(
        title: String,
        tagStyle: TagStyle,
        tapTagControl: @escaping () -> ()) {
        self.title = title
        self.tapTagControl = tapTagControl
        self.tagStyle = tagStyle
    }
    
    public init<L : View>(
        title: String,
        tagStyle: TagStyle,
        @ViewBuilder leadingView: @escaping () -> L,
        tapTagControl: @escaping () -> ()) {
        self.title = title
        self.tapTagControl = tapTagControl
        self.tagStyle = tagStyle
        self.leadingView = { return leadingView().eraseToAnyView() }
    }
    
    public init<V : View>(
        tagStyle: TagStyle,
        @ViewBuilder view: @escaping () -> V,
        tapTagControl: @escaping () -> ()) {
        self.tapTagControl = tapTagControl
        self.tagStyle = tagStyle
        self.leadingView = { return view().eraseToAnyView() }
    }
    
    public init<T : View>(
        title: String,
        tagStyle: TagStyle,
        @ViewBuilder trailingView: @escaping () -> T,
        tapTagControl: @escaping () -> ()) {
        self.title = title
        self.tapTagControl = tapTagControl
        self.tagStyle = tagStyle
        
        self.trailingView = { return trailingView().eraseToAnyView() }
    }
    
    public init<L : View, T: View>(
        title: String,
        tagStyle: TagStyle,
        @ViewBuilder leadingView: @escaping () -> L,
        @ViewBuilder trailingView: @escaping () -> T,
        tapTagControl: @escaping () -> ()) {
        self.title = title
        self.tapTagControl = tapTagControl
        self.tagStyle = tagStyle
        
        self.leadingView = { return leadingView().eraseToAnyView() }
        self.trailingView = { return trailingView().eraseToAnyView() }
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let controlState: ControlState = isEnabled ? (isPressing ? .selected : .normal) : .disabled
        HStack(alignment: .center, spacing : LayoutGrid.module) {
            Spacer()
                .frame(width: LayoutGrid.module)
            if let leadingView = leadingView {
                leadingView()
                    .opacity(scheme.leadingTrailingViewsAlpha.parameter(for: controlState) ?? 1.0)
                    .foregroundColor(scheme.viewTintColor.parameter(for: controlState, style: tagStyle)?.swiftUIColor)
                    .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
            }
            if let title = title {
                Text(title)
                    .font(scheme.font.swiftUIFont)
                    .foregroundColor(scheme.textColor.parameter(for: controlState, style: tagStyle)?.swiftUIColor)
            }
            if let trailingView = trailingView {
                trailingView()
                    .opacity(scheme.leadingTrailingViewsAlpha.parameter(for: controlState) ?? 1.0)
                    .foregroundColor(scheme.viewTintColor.parameter(for: controlState, style: tagStyle)?.swiftUIColor)
                    .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
            }
            Spacer()
                .frame(width: LayoutGrid.module)
        }
        .frame(height: LayoutGrid.halfModule * 9)
        .background(scheme.backgroundColor.parameter(for: controlState, style: tagStyle)?.swiftUIColor)
        .cornerRadius((LayoutGrid.halfModule * 9) / 2)
        .onTapGesture {
            tapTagControl()
        }
    }
}

@available(iOS 14.0, *)
struct TagControl_Previews: PreviewProvider {
    
    static var previews: some View {
        TagControl(title: "Title",
                   tagStyle: .attention,
                   leadingView: { Button(action: {}, label: {
                    Image(uiImage: Asset.Category.Outline.bankOutline.image)
                   }) },
                   trailingView: {
                    Button(action: {}, label: {
                        Image(uiImage: Asset.Category.Outline.bankOutline.image)
                    }) }) {
            
        }
    }
}
