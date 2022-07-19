//
//  SwiftUIController.swift
//  ExampleiOS
//
//  Created by ADyatkov on 08.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CustomSwiftUIView: View {
    
    @ObservedObject private var theme: SwiftUIContentViewObservable

    init(theme: SwiftUIContentViewObservable) {
        self.theme = theme
    }
    
    public var body: some View {
        List {
            ForEach(SwiftUIItem.allCases, id: \.self) { item in
                NavigationLink(destination: view(for: item)) {
                    ItemSwiftUIRow(item: item)
                        .frame(height: 68)
                        .environmentObject(ItemSwiftUIRowObservable())
                }
            }
            .listRowBackground(theme.backgroundColor).edgesIgnoringSafeArea(.all)
            .navigationTitle("SwiftUI")
        }
    }
    
    @ViewBuilder
    func view(for type: SwiftUIItem) -> some View {
        switch type {
        case .buttons:
            ButtonsSwiftUIView().environmentObject(SwiftUIContentViewObservable())
        case .switcher:
            SwitcherSwiftUIView().environmentObject(SwiftUIContentViewObservable())
        case .radioButton:
            RadioButtonSwiftUIView().environmentObject(SwiftUIContentViewObservable())
        case .checkbox:
            CheckBoxSwiftUIView().environmentObject(SwiftUIContentViewObservable())
        case .tabs:
            TabsSwiftUIView().environmentObject(SwiftUIContentViewObservable())
        case .textFields:
            TextFieldsSwiftUIView().environmentObject(SwiftUIContentViewObservable())
        default:
            EmptyView()
        }
    }
    
}

@available(iOS 14.0.0, *)
class SwiftUIController: UIHostingController<CustomSwiftUIView>, AnyAppThemable {
    
    init() {
        super.init(rootView: CustomSwiftUIView(theme: SwiftUIContentViewObservable()))
        UIScrollView.appearance().backgroundColor = .clear
        configureUI()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
    }
}
