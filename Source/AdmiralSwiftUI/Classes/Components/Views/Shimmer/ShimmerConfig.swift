//
//  ShimmerConfig.swift
//  AdmiralSwiftUI
//
//  Created on 25.06.2021.
//

import SwiftUI
import AdmiralTheme
import Combine

@available(iOS 14.0.0, *)
public class ShimmerConfig: ObservableObject {
    
    // MARK: - Public Properties
    
    public let willChange = PassthroughSubject<ShimmerConfig, Never>()
    
    // MARK: - Internal Properties
    
    @Published var isActive: Bool = false
    
    var bgColor: Color
    var shimmerColor: Color
    var shimmerAngle: Double
    var shimmerDuration: Double
    
    // MARK: - Private Properties

    private var timer: AnyCancellable?
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object.
    /// - Parameters:
    ///   - theme: App theme.
    ///   - shimmerAngle: Shimmer angle.
    ///   - shimmerDuration: Shimmer duration.
    ///   - shimmerDelay: Shimmer delay.
    public init(
        theme: AppTheme,
        shimmerAngle: Double = 0,
        shimmerDuration: TimeInterval = 2,
        shimmerDelay: TimeInterval = 1
    ) {

        self.bgColor = theme.colors.backgroundAdditionalOne.swiftUIColor
        self.shimmerColor = theme.colors.elementStaticWhite.swiftUIColor
        self.shimmerAngle = shimmerAngle
        self.shimmerDuration = shimmerDuration

        self.timer = Timer
               .publish(every: shimmerDuration + shimmerDelay, on: RunLoop.main, in: RunLoop.Mode.default)
               .autoconnect()
               .sink(receiveValue: { [weak self] _ in
            guard let self = self else { return }
            self.isActive = false
            
            withAnimation { self.isActive = true }
        })
    }
    
    /// Initializes and returns a newly allocated view object.
    /// - Parameters:
    ///   - bgColor: Background shimmer view color.
    ///   - shimmerColor: Shimmer color.
    ///   - shimmerAngle: Shimmer angle.
    ///   - shimmerDuration: Shimmer duration.
    ///   - shimmerDelay: Shimmer delay.
    public init(bgColor: Color,
                shimmerColor: Color,
                shimmerAngle: Double = 0,
                shimmerDuration: TimeInterval = 2,
                shimmerDelay: TimeInterval = 1
    ) {
        self.bgColor = bgColor
        self.shimmerColor = shimmerColor
        self.shimmerAngle = shimmerAngle
        self.shimmerDuration = shimmerDuration

        self.timer = Timer
               .publish(every: shimmerDuration + shimmerDelay, on: RunLoop.main, in: RunLoop.Mode.default)
               .autoconnect()
               .sink(receiveValue: { [weak self] _ in
            guard let self = self else { return }
            self.isActive = false
            
            withAnimation { self.isActive = true }
        })
    }
    
    deinit {
        timer?.cancel()
        timer = nil
    }
    
}
