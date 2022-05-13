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

    // MARK: - Private Properties

    @StateObject private var viewModel = TagsChipsViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView {
                StandardTab(items: viewModel.tabItems, selection: $viewModel.isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                    ForEach(TagsChipsViewModel.TagChipiItem.allCases, id: \.self) { item in
                        buildItem(item: item, scheme: scheme)
                    }
                }
                .disabled(viewModel.isEnabledControlsState != 0)
                .padding()
            }
        }
    }

    // MARK: - Private Methods

    private func buildItem(item: TagsChipsViewModel.TagChipiItem, scheme: SwiftUIContentViewScheme) -> some View {
        VStack(alignment: .leading) {
            Text(item.rawValue)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
            switch item {
            case .default:
                defaultTags()
            case .additional:
                defaultAdditional()
            case .success:
                defaultSuccess()
            case .erro:
                defaultError()
            case .attention:
                defaultAttention()
            }
            Spacer()
                .frame(height: LayoutGrid.doubleModule)
        }
    }

    private func defaultTags() -> some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: LayoutGrid.module, content: {
                configureLeadingTraiingTagControl(title: "Chip",
                                                  tagStyle: .default,
                                                  leftImage: Image(uiImage: Asset.TagsChips.carSolid.image),
                                                  rightButtonImage: Image(uiImage: AdmiralUIResources.Asset.Service.Solid.closeSolid.image))
                configureTrailingTagControl(title: "Chip",
                                            tagStyle: .default,
                                            rightButtonImage: Image(uiImage: AdmiralUIResources.Asset.Service.Solid.closeSolid.image))
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
    
    private func configureLeadingTraiingTagControl(title: String, tagStyle: TagStyle, leftImage: Image, rightButtonImage: Image) -> some View {
        TagControl(
            title: title,
            tagStyle: tagStyle,
            leadingView: { leftImage },
            trailingView: {
                SwiftUI.Button(action: {}, label: {
                    rightButtonImage
                })
            },
            tapTagControl: {})
    }
    
    private func configureTrailingTagControl(title: String, tagStyle: TagStyle, rightButtonImage: Image) -> some View {
        TagControl(
            title: title,
            tagStyle: tagStyle,
            trailingView: {
                SwiftUI.Button(action: {}, label: {
                    rightButtonImage
                })
            },
            tapTagControl: {})
    }
    
}
