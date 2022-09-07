//
//  ArrowSegmentSlider.swift
//  AdmiralSwiftUI
//
//  Created on 28.04.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

@available(iOS 14.0.0, *)
struct ArrowSegmentSlider: View {
    
    enum Constants {
        static let imageSize = CGSize(width: 32.0, height: 12.0)
        static let arrowImage = SystemAsset.Custom.Segment.arrowUp.image
        static let animationDuration: Double = 0.3
    }
    
    // MARK: - Private Properties
    
    @State private var scheme: ArrowSegmentSliderScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ArrowSegmentSliderScheme>()
    
    var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        Image(uiImage: Constants.arrowImage)
            .frame(width: Constants.imageSize.width)
            .frame(height: Constants.imageSize.height)
            .animation(Animation.easeInOut(duration: Constants.animationDuration))
            .foregroundColor(scheme.imageTintColor.swiftUIColor)
    }
    
}
