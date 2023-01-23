//
//  TagsChipsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 29.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct TagsChipsSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Tags & Chips") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(showsIndicators: false) {
                StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                            selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                    VStack(alignment: .leading) {
                        Text("Default")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        defaultTags()
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                    }
                    VStack(alignment: .leading) {
                        Text("Additional")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        defaultAdditional()
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                    }
                    VStack(alignment: .leading) {
                        Text("Success")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        defaultSuccess()
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                    }
                    VStack(alignment: .leading) {
                        Text("Error")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        defaultError()
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                    }
                    VStack(alignment: .leading) {
                        Text("Attention")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        defaultAttention()
                        Spacer()
                            .frame(height: LayoutGrid.doubleModule)
                    }
                }
                .disabled(isEnabledControlsState != 0)
                .padding()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func defaultTags() -> some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: LayoutGrid.module, content: {
                configureLeadingTraiingTagControl(title: "Chip",
                                                  tagStyle: .default,
                                                  leftImage: Image(uiImage: Asset.TagsChips.carSolid.image),
                                                  rightButtonImage: Image(uiImage: AdmiralUIResources.Asset.Service.Solid.closeSolid.image),
                                                  rightButtonAccessibilityID: "DefaultRightButtonFirst")
                configureTrailingTagControl(title: "Chip",
                                            tagStyle: .default,
                                            rightButtonImage: Image(uiImage: AdmiralUIResources.Asset.Service.Solid.closeSolid.image),
                                            rightButtonAccessibilityID: "DefaultRightButtonSecond")
                configureLeadingTagControl(title: "Icons",
                                           tagStyle: .default,
                                           leftImage: Image(uiImage: Asset.TagsChips.carSolid.image))
                configureEmojiTagControl(title: "Emoji", tagStyle: .default, emoji: "🐶")
                configureLeadingTagControl(title: "Flags",
                                           tagStyle: .default,
                                           leftImage: Image(uiImage: Asset.TagsChips.russiaFlag.image))
            })
        })
        .frame(height: 64.0)
    }
    
    private func defaultAdditional() -> some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: LayoutGrid.module, content: {
                configureLeadingTagControl(title: "Icons",
                                           tagStyle: .additional,
                                           leftImage: Image(uiImage: Asset.TagsChips.carSolid.image))
                configureEmojiTagControl(title: "Emoji", tagStyle: .additional, emoji: "🐶")
                configureLeadingTagControl(title: "Flags",
                                           tagStyle: .additional,
                                           leftImage: Image(uiImage: Asset.TagsChips.russiaFlag.image))
            })
        })
    }
    
    private func defaultSuccess() -> some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: LayoutGrid.module, content: {
                configureLeadingTagControl(title: "Icons",
                                           tagStyle: .success,
                                           leftImage: Image(uiImage: Asset.TagsChips.carSolid.image))
                configureEmojiTagControl(title: "Emoji", tagStyle: .success, emoji: "🐶")
                configureLeadingTagControl(title: "Flags",
                                           tagStyle: .success,
                                           leftImage: Image(uiImage: Asset.TagsChips.russiaFlag.image))
            })
        })
    }
    
    private func defaultError() -> some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: LayoutGrid.module, content: {
                configureLeadingTagControl(title: "Icons",
                                           tagStyle: .error,
                                           leftImage: Image(uiImage: Asset.TagsChips.carSolid.image))
                configureEmojiTagControl(title: "Emoji", tagStyle: .error, emoji: "🐶")
                configureLeadingTagControl(title: "Flags",
                                           tagStyle: .error,
                                           leftImage: Image(uiImage: Asset.TagsChips.russiaFlag.image))
            })
        })
    }
    
    private func defaultAttention() -> some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: LayoutGrid.module, content: {
                configureLeadingTagControl(title: "Icons",
                                           tagStyle: .attention,
                                           leftImage: Image(uiImage: Asset.TagsChips.carSolid.image))
                configureEmojiTagControl(title: "Emoji", tagStyle: .attention, emoji: "🐶")
                configureLeadingTagControl(title: "Flags",
                                           tagStyle: .attention,
                                           leftImage: Image(uiImage: Asset.TagsChips.russiaFlag.image))
            })
        })
    }
    
    private func configureTagControl(title: String, tagStyle: TagStyle) -> some View {
        TagControl(title: title, tagStyle: tagStyle, tapTagControl: {})
    }
    
    private func configureEmojiTagControl(title: String, tagStyle: TagStyle, emoji: String) -> some View {
        TagControl(
            title: title,
            tagStyle: tagStyle,
            leadingView: { Text(emoji) },
            tapTagControl: {})
    }
    
    private func configureLeadingTagControl(title: String, tagStyle: TagStyle, leftImage: Image) -> some View {
        TagControl(
            title: title,
            tagStyle: tagStyle,
            leadingView: { leftImage },
            tapTagControl: {})
    }
    
    private func configureLeadingTraiingTagControl(title: String, tagStyle: TagStyle, leftImage: Image, rightButtonImage: Image, rightButtonAccessibilityID: String) -> some View {
        TagControl(
            title: title,
            tagStyle: tagStyle,
            leadingView: { leftImage },
            trailingView: {
                SwiftUI.Button(action: {}, label: {
                    rightButtonImage
                })
                    .accessibility(identifier: rightButtonAccessibilityID)
            },
            tapTagControl: {})
    }
    
    private func configureTrailingTagControl(title: String, tagStyle: TagStyle, rightButtonImage: Image, rightButtonAccessibilityID: String) -> some View {
        TagControl(
            title: title,
            tagStyle: tagStyle,
            trailingView: {
                SwiftUI.Button(action: {}, label: {
                    rightButtonImage
                })
                    .accessibility(identifier: rightButtonAccessibilityID)
            },
            tapTagControl: {})
    }
    
}
