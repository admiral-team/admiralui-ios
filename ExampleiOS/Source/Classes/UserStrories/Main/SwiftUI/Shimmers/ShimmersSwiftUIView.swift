import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ShimmersSwiftUIView: View {

    // MARK: - Private Methods

    @StateObject private var viewModel = ShimmersSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ShimmersSwiftUIViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.items, id: \.id) { item in
                        shimmerItem(item: item)
                    }
                    Rectangle()
                        .cornerRadius(LayoutGrid.halfModule)
                        .shimmer(isActive: true)
                        .frame(height: 64.0)
                        .padding()
                    Spacer()
                }
            }
        }
        .environmentObject(
            ShimmerConfig(
                bgColor: scheme.backgroundShimmerColor.swiftUIColor,
                shimmerColor: scheme.shimmerColor.swiftUIColor
            )
        )
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func shimmerItem(item: ShimmersSwiftUIViewModel.ShimmerItem) -> some View {
        ListCell(leadingView: {
            ImageCardListView(cardImage: item.image)
                .if(item.isActive == .imageCardList) { view in
                    view.shimmer(isActive: true)
                }
        }, centerView: {
            TitleMoreDetailTextMessageListView(
                title: item.title,
                detaile: item.detail
            )
                .if(item.isActive == .titleMore) { view in
                    view.shimmer(isActive: true)
                }
        }, trailingView: {
            IconListView(image: Image(uiImage: Asset.Card.visaLabel.image))
                .if(item.isActive == .iconList) { view in
                    view.shimmer(isActive: true)
                }
        })
    }
}
