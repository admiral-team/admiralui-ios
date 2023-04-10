//
//  CalendarHorizontalHeaderView.swift
//  AdmiralSwiftUI
//
//  Created on 13.07.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import SwiftUI

@available(iOS 14.0.0, *)
public struct CalendarHorizontalHeaderView: View {

    // MARK: - Constants

    enum Constants {
        static let choiceText = "Выбрать"
    }

    // MARK: - Internal Properties

    @Environment(\.isEnabled) var isEnabled

    @Binding var title: String
    @Binding var isOpen: Bool

    var monthYearButtonTap: () -> Void
    var leftArrowTap: () -> Void
    var rightArrowTap: () -> Void
    var choiceTap: () -> Void

    // MARK: - Schemes

    @ObservedObject var schemeProvider: SchemeProvider<CalendarHorizontalHeaderViewScheme>

    // MARK: - Initializer

    public init(
        title: String,
        isOpen: Binding<Bool>,
        monthYearButtonTap: @escaping () -> Void,
        leftArrowTap: @escaping () -> Void,
        rightArrowTap: @escaping () -> Void,
        choiceTap: @escaping () -> Void,
        schemeProvider: SchemeProvider<CalendarHorizontalHeaderViewScheme> = AppThemeSchemeProvider<CalendarHorizontalHeaderViewScheme>()
    ) {
        self._title = Binding(
            get: { title },
            set: { _, _ in  }
        )
        self._isOpen = isOpen
        self.monthYearButtonTap = monthYearButtonTap
        self.leftArrowTap = leftArrowTap
        self.rightArrowTap = rightArrowTap
        self.choiceTap = choiceTap
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        let buttonImage = isOpen ?
        Image(uiImage: Asset.System.Outline.chevronDownOutline.image) :
        AssetSymbol.System.Outline.smallArrowUp.image
        let buttonColor = scheme.buttonColor.parameter(for: isEnabled ? .normal : .disabled)
        return ZStack {
            HStack {
                Button(title, action: monthYearButtonTaped)
                    .buttonStyle(
                        MonthYearButtonStyle(
                            image: buttonImage,
                            schemeProvider: SchemeProvider.constant(scheme: scheme.monthYearButtonScheme)
                        )
                    )
                Spacer()
                if isOpen {
                    Button(action: leftArrowTaped, label: {
                        AssetSymbol.System.Outline.chevronLeft.image
                    })
                    .foregroundColor(buttonColor?.swiftUIColor)
                    .frame(width: LayoutGrid.tripleModule, height: LayoutGrid.tripleModule)
                    Spacer()
                        .frame(width: LayoutGrid.doubleModule)
                    Button(action: rightArrowTap, label: {
                        AssetSymbol.System.Outline.chevronRight.image
                    })
                    .foregroundColor(buttonColor?.swiftUIColor)
                    .frame(width: LayoutGrid.tripleModule, height: LayoutGrid.tripleModule)
                } else {
                    Button(Constants.choiceText, action: choiceTap)
                        .buttonStyle(GhostButtonStyle())
                }
            }
        }

    }

    // MARK: - Private Methods

    private func monthYearButtonTaped() {
        monthYearButtonTap()
    }

    private func leftArrowTaped() {
        leftArrowTap()
    }

    private func rightArrowTaped() {
        rightArrowTap()
    }

}

@available(iOS 14.0, *)
struct CalendarHorizontalHeaderView_Previews: PreviewProvider {

    static var previews: some View {
        CalendarHorizontalHeaderView(
            title: "Май 2021",
            isOpen: .constant(true),
            monthYearButtonTap: {},
            leftArrowTap: {},
            rightArrowTap: {},
            choiceTap: {}
        )
        .previewLayout(PreviewLayout.sizeThatFits)
        .frame(height: 16.0)
        .padding()
        .environment(\.manager, SwiftUIThemeManager(theme: .light))
    }
}
