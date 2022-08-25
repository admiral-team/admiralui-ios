//
//  OnBoardingPageUIView.swift
//  ExampleiOS
//
//  Created on 18.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct OnBoardingPageUIView: View {
    
    // MARK: - Properties
    
    var title: String
    var subtitle: String
    var imageName: String
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<OnBoardingCustomScheme>()
    
    // MARK: - Layout
    
    var body: some View {
        let scheme = schemeProvider.scheme
        VStack(spacing: 0) {
            Image(imageName)
                .frame(width: LayoutGrid.halfModule * 50, height: LayoutGrid.halfModule * 50)
                .background(schemeProvider.scheme.imageBackground.swiftUIColor)
                .cornerRadius(LayoutGrid.halfModule * 25)
            
            Spacer()
                .frame(height: LayoutGrid.module * 5)
            
            Text(title)
                .font(schemeProvider.scheme.titleLabelFont.swiftUIFont)
                .foregroundColor(schemeProvider.scheme.titleLabelColor.swiftUIColor)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(scheme.descriptionLabelTextFont.swiftUIFont)
                .foregroundColor(scheme.descriptionLabelTextColor.swiftUIColor)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
