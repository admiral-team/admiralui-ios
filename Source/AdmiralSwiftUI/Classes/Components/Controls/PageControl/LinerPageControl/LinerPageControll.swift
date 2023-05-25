//
//  LinerPageControll.swift
//  AdmiralUIResources
//
//  Created on 30.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 Liner - A horizontal page control logically corresponds to the Circle option, while there is an additional option to switch pages using a swipe of the whole page. Additionally, when using this option, it is necessary to provide for the use of the “Next” button.
 
 You can create a Liner by specifying the following parameters in the initializer:
 
 - currentPage - Binding property  of UnderlineTabItem. Each element of the array is a tab of Segment Control with title and badge style.
 - selection - the number of page control items that are currently displayed
 - displayedItems - the number of page control items that are currently displayed
 
 Example to create Liner:
 Code
 ```
 @State private var selectionItem = 0
 
 VStack(alignment: .center, spacing: LayoutGrid.tripleModule * 3) {
 LinerPageControll(currentPage: $selectionItem, numberOfPages: -5, displayedItems: 5)
 
 SwiftUI.Button {
 selectionItem += 1
 } label: {
 HStack {
 Text("Next")
 System.Outline.arrowRight.image
 }
 }
 .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
 }
 ```
 */
@available(iOS 14.0.0, *)
public struct LinerPageControll: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let widthLinerItem = LayoutGrid.doubleModule
        static let heightLinerItem = LayoutGrid.halfModule
        static let leadingPaddingItem = LayoutGrid.module
    }
    
    // MARK: - Internal Propeties
    
    /// Returns the current selected page of pafge control
    @Binding var currentPage: Int
    
    // MARK: - Private Propeties
    
    /// The number of page control items that are currently displayed
    private var displayedItems: Int
    
    /// Returns the current selected page of pafge control
    private var numberOfPages: Int
    
    @ObservedObject private var schemeProvider: SchemeProvider<PageControlViewScheme>
    
    // MARK: - Initializer
    
    public init(
        currentPage: Binding<Int> = .constant(0),
        numberOfPages: Int = 6,
        displayedItems: Int = 5,
        schemeProvider: SchemeProvider<PageControlViewScheme> = AppThemeSchemeProvider<PageControlViewScheme>()
    ) {
        self._currentPage = currentPage
        self.numberOfPages = numberOfPages
        self.displayedItems = displayedItems
        self.schemeProvider = schemeProvider
    }
    
    // MARK: - Layout
    
    public var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(spacing: 0) {
                        ForEach(0..<numberOfPages, id: \.self) { index in
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
            }
        }
        .frame(width: calculateWidth(), height: LayoutGrid.halfModule * 5)
        .disabled(true)
    }
    
    // MARK: - Private methods
    
    private func getlinerItemView(for index: Int) -> some View {
        let scheme = schemeProvider.scheme
        let selectedPage = currentPage >= numberOfPages ? numberOfPages - 1 : currentPage
        let isSelected = selectedPage == index
        
        return RoundedRectangle(cornerRadius: LayoutGrid.module)
            .frame(width: Constants.widthLinerItem, height: Constants.heightLinerItem)
            .foregroundColor(isSelected ?
                             scheme.backgroundColor.parameter(for: .selected)?.swiftUIColor :
                                scheme.backgroundColor.parameter(for: .normal)?.swiftUIColor)
            .padding(.leading, index == 0 ? 0 : Constants.leadingPaddingItem)
    }
    
    private func calculateWidth() -> CGFloat {
        if displayedItems == 1 {
            return (CGFloat(displayedItems) * Constants.widthLinerItem)
        } else if displayedItems < 1 {
            return .zero
        } else if displayedItems < numberOfPages {
            return (CGFloat(displayedItems) * Constants.widthLinerItem) + (CGFloat((displayedItems - 1)) * Constants.leadingPaddingItem)
        } else {
            return (CGFloat(numberOfPages) * Constants.widthLinerItem) + (CGFloat((numberOfPages - 1)) * Constants.leadingPaddingItem)
        }
    }
}

@available(iOS 14.0.0, *)
struct LinerPageControll_Previews: PreviewProvider {
    static var previews: some View {
        LinerPageControll(
            currentPage: .constant(0),
            numberOfPages: 6
        )
    }
}
