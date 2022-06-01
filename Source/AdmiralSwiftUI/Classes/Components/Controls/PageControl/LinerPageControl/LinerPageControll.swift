//
//  LinerPageControll.swift
//  AdmiralUIResources
//
//  Created on 30.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct LinerPageControll: View {
    
    // MARK: - Internal Propeties
    
    /// Returns the current selected page of pafge control
    @Binding var currentPage: Int
    
    // MARK: - Private Propeties
    
    /// The number of page control items that are currently displayed
    private var displayedItems: Int
    private var scheme: PageControlViewScheme? = nil
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<PageControlViewScheme>()
    
    // MARK: - Initializer
    
    public init(currentPage: Binding<Int> = .constant(0),
                displayedItems: Int = 6) {
        self._currentPage = currentPage
        self.displayedItems = displayedItems
    }
    
    // MARK: - Layout
    
    public var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(spacing: 0) {
                        ForEach(0..<displayedItems) { index in
                            getlinerItemView(for: index)
                                .id(index)
                        }
                        .onChange(of: currentPage) { newValue in
                            withAnimation {
                                value.scrollTo(newValue, anchor: .trailing)
                            }
                        }
                    }
                }
                .moveDisabled(true)
            }.disabled(true)
        }
    }
    
    // MARK: - Private methods
    
    private func getlinerItemView(for index: Int) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let selectedPage = currentPage >= displayedItems ? displayedItems - 1 : currentPage
        let isSelected = selectedPage == index
        
        return RoundedRectangle(cornerRadius: LayoutGrid.module)
            .frame(width: LayoutGrid.doubleModule, height: LayoutGrid.halfModule)
            .foregroundColor(isSelected ?
                             scheme.backgroundColor.parameter(for: .selected)?.swiftUIColor :
                                scheme.backgroundColor.parameter(for: .normal)?.swiftUIColor)
            .padding(.leading, index == 0 ? 0 : LayoutGrid.module)
    }
}

@available(iOS 14.0.0, *)
struct LinerPageControll_Previews: PreviewProvider {
    static var previews: some View {
        LinerPageControll(currentPage: .constant(0))
    }
}
