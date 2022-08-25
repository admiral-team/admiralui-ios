//
//  InfoSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.04.2021.
//

import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources
import SwiftUI

@available(iOS 14.0.0, *)
struct InfoSwiftUIView: View {
    
    enum Constants {
        static let imageSize = CGSize(width: 21.0, height: 21.0)
        static let viewWidth: CGFloat = 260.0
        static let contentWidth: CGFloat = 236.0
    }
    
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<InfoSwiftUIViewScheme>()
    
    @Binding private var title: String
    @Binding private var subtitle: String
    @Binding private var description: String
    
    @Environment(\.isEnabled) private var isEnabled
    
    init(title: Binding<String>, subtitle: Binding<String>, description: Binding<String>) {
        self._title = title
        self._subtitle = subtitle
        self._description = description
    }
    
    var body: some View {
        let scheme = schemeProvider.scheme
        ZStack {
            isEnabled ?
                scheme.wrapViewBackgroundColors.parameter(for: .normal)?.swiftUIColor :
                scheme.wrapViewBackgroundColors.parameter(for: .disabled)?.swiftUIColor
            VStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .font(scheme.titleLabelFont.swiftUIFont)
                    .foregroundColor(isEnabled ?
                                        scheme.titleLabelTextColors.parameter(for: .normal)?.swiftUIColor
                                        : scheme.titleLabelTextColors.parameter(for: .disabled)?.swiftUIColor)
                HStack {
                    Text(subtitle)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(scheme.descriptionLabelFont.swiftUIFont)
                        .foregroundColor(isEnabled ?
                                            scheme.descriptionLabelTextColors.parameter(for: .normal)?.swiftUIColor
                                            : scheme.descriptionLabelTextColors.parameter(for: .disabled)?.swiftUIColor)
                    Image(uiImage: Asset.Info.helpSolid.image)
                        .frame(
                            width: Constants.imageSize.width,
                            height: Constants.imageSize.height)
                        .foregroundColor(isEnabled ?
                                            scheme.descriptionImageViewTintColors.parameter(for: .normal)?.swiftUIColor :
                                            scheme.descriptionImageViewTintColors.parameter(for: .disabled)?.swiftUIColor)
                }
                .frame(width: Constants.contentWidth)
                Text(description)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(scheme.subtitleLabelFont.swiftUIFont)
                    .foregroundColor(isEnabled ?
                                        scheme.subtitleLabelTextColors.parameter(for: .normal)?.swiftUIColor
                                        : scheme.subtitleLabelTextColors.parameter(for: .disabled)?.swiftUIColor)
                    .frame(width: Constants.contentWidth)
            }
        }
        .frame(minHeight: 0, idealHeight: 170.0, maxHeight: 200.0)
        .frame(minWidth: 0, idealWidth: Constants.viewWidth, maxWidth: .infinity)
    }
}

@available(iOS 14.0.0, *)
struct InfoSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        InfoSwiftUIView(title: .constant("то получу в страховом случае"),
                        subtitle: .constant("до 1 500 000 ₽"),
                        description: .constant("Выгодный вариант для  двухкомнатной квартиры или дачного дома"))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("InfoSwiftUIView preview")
    }
}
