//
//  OnboardingSwiftUIView.swift
//  ExampleiOS
//
//  Created by Алмазов Иван Александрович on 08.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct OnBoardingSwiftUIView: View {
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<OnBoardingCustomScheme>()
    @State private var steps: Int = 1
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Onboarding") {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: LayoutGrid.module * 4)
                Image(Asset.Onboarding.one.name)
                    .frame(width: LayoutGrid.halfModule * 50, height: LayoutGrid.halfModule * 50)
                    .background(schemeProvider.scheme.imageBackground.swiftUIColor)
                    .cornerRadius(LayoutGrid.halfModule * 25)
                
                Spacer()
                    .frame(height: LayoutGrid.module * 5)
                
                Text("Header")
                    .font(schemeProvider.scheme.titleLabelFont.swiftUIFont)
                    .foregroundColor(schemeProvider.scheme.titleLabelColor.swiftUIColor)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                    .font(scheme.descriptionLabelTextFont.swiftUIFont)
                    .foregroundColor(scheme.descriptionLabelTextColor.swiftUIColor)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                SwiftUI.Button(action: {}, label: {})
                    .buttonStyle(
                        CirclePageControlStyle(
                            step: $steps,
                            totalPages: 1,
                            style: .default
                        )
                    )
                Spacer()
                    .frame(height: LayoutGrid.module * 11)
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity)
            .background(scheme.backgroundColor.swiftUIColor)
        }
    }
}

@available(iOS 14.0, *)
struct OnBoardingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingSwiftUIView()
    }
}
