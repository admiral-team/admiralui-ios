//
//  TextFieldInput.swift
//  AdmiralSwiftUI
//
//  Created on 07.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct TextInputDecorationBox<T, P>: View where T: View, P: View {
    
    @Binding var textFieldView: () -> T
    
    @Binding var name: String
    @Binding var placeholder: String
    
    @Binding var additionalView: P?
    
    @Binding var info: String
    @Binding var infoNumberOfLines: Int?
    
    @Binding var placeholderColor: Color?
    @Binding var infoColor: Color?
    @Binding var tintColor: Color?
    @Binding var underlineColor: Color?
    
    @Binding var textFieldFont: AFont?
    @Binding var nameFont: AFont?
    @Binding var informerFont: SwiftUI.Font?
    
    @Binding var separatorLineMode: SeparatorLineMode
    
    @Binding var nameOffset: CGFloat
    @Binding var nameFilledOffset: CGFloat
    @Binding var placeholderOffset: CGFloat
    @Binding var segmentSize: CGSize
    
    @Binding var isFocused: Bool
    @Binding var isFilled: Bool
    @Binding var isTextFieldDisabled: Bool
    
    var accessibilityIdentifier: String?
    
    public var body: some View {
        return ZStack {
            VStack(spacing: 0) {
                placeholderNameTextViews(
                    placeholderColor: placeholderColor,
                    infoColor: infoColor,
                    tintColor: tintColor,
                    textFieldFont: textFieldFont,
                    nameFont: nameFont)
                    .padding(.top, LayoutGrid.halfModule * 3)
                textFieldView()
                Line(mode: separatorLineMode)
                    .padding(.top, 5)
                    .foregroundColor(isFocused ? tintColor : underlineColor)
                    .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
                
                if let additionalView = self._additionalView.wrappedValue, !(additionalView is EmptyView) {
                    HStack {
                        additionalView
                        Spacer()
                    }
                    .padding(.top, LayoutGrid.module)
                }
                if !info.isEmpty {
                    Text(info)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(infoColor)
                        .font(informerFont)
                        .lineLimit(infoNumberOfLines)
                        .padding(.top, LayoutGrid.module)
                        .padding(.bottom, LayoutGrid.module)
                        .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.info.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
                }
            }
        }
    }
    
    init(
        @ViewBuilder textFieldView: @escaping () -> T,
        name: String,
        placeholder: String,
        additionalView: P? = nil,
        info: Binding<String>,
        infoNumberOfLines: Int?,
        placeholderColor: Color?,
        infoColor: Color?,
        tintColor: Color?,
        underlineColor: Color?,
        textFieldFont: AFont?,
        nameFont: AFont?,
        informerFont: SwiftUI.Font?,
        nameOffset: CGFloat = LayoutGrid.halfModule * 5,
        nameFilledOffset: CGFloat = -LayoutGrid.module,
        placeholderOffset: CGFloat = LayoutGrid.halfModule * 5.5,
        segmentSize: Binding<CGSize> = .constant(.zero),
        separatorLineMode: SeparatorLineMode,
        isFocused: Binding<Bool>,
        isFilled: Binding<Bool>,
        isTextFieldDisabled: Bool,
        accessibilityIdentifier: String? = nil) {

        self._textFieldView = Binding(
            get: { textFieldView },
            set: { _, _ in  }
        )
        self._name = Binding(
            get: { name },
            set: { _, _ in  }
        )
        self._placeholder = Binding(
            get: { placeholder },
            set: { _, _ in  }
        )
        self._additionalView = Binding(
            get: { additionalView },
            set: { _, _ in  }
        )
        self._info = info
        self._infoNumberOfLines = Binding(
            get: { infoNumberOfLines },
            set: { _, _ in  }
        )
        self._placeholderColor = Binding(
            get: { placeholderColor },
            set: { _, _ in  }
        )
        self._infoColor = Binding(
            get: { infoColor },
            set: { _, _ in  }
        )
        self._tintColor = Binding(
            get: { tintColor },
            set: { _, _ in  }
        )
        self._underlineColor = Binding(
            get: { underlineColor },
            set: { _, _ in  }
        )
        self._textFieldFont = Binding(
            get: { textFieldFont },
            set: { _, _ in  }
        )
        self._nameFont = Binding(
            get: { nameFont },
            set: { _, _ in  }
        )
        self._informerFont = Binding(
            get: { informerFont },
            set: { _, _ in  }
        )
        self._nameOffset = Binding(
            get: { nameOffset },
            set: { _, _ in  }
        )
        self._nameFilledOffset = Binding(
            get: { nameFilledOffset },
            set: { _, _ in  }
        )
        self._placeholderOffset = Binding(
            get: { placeholderOffset },
            set: { _, _ in  }
        )
        
        self._segmentSize = segmentSize
        self._separatorLineMode = Binding(
            get: { separatorLineMode },
            set: { _, _ in  }
        )
        self._isFocused = isFocused
        self._isFilled = isFilled
        self._isTextFieldDisabled = Binding(
            get: { isTextFieldDisabled },
            set: { _, _ in  }
        )
        
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    private func placeholderNameTextViews(
        placeholderColor: Color?,
        infoColor: Color?,
        tintColor: Color?,
        textFieldFont: AFont?,
        nameFont: AFont?) -> some View {
        return ZStack(alignment: .leading) {
                HStack {
                    Text("\(placeholder)")
                        .offset(y: placeholderOffset)
                        .foregroundColor(placeholderColor)
                        .font(textFieldFont?.swiftUIFont)
                        .opacity(!isFilled && isFocused ? 1 : 0)
                        .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.placeholder.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
                    Spacer()
                }
                
                Text("\(name)")
                    .offset(y: isFilled || isFocused ? nameFilledOffset : nameOffset)
                    .foregroundColor(isFocused ? tintColor : infoColor)
                    .modifier(AnimatingFontSize(
                        fontSize: (isFilled || isFocused) ? (nameFont?.size ?? 0.0) : (textFieldFont?.size ?? 0.0),
                        fontName: (isFilled || isFocused) ? (nameFont?.name ?? "") : (textFieldFont?.name ?? "")))
                    .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.name.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
            }
        }

}
