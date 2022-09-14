//
//  CountdownView.swift
//  AdmiralSwiftUI
//
//  Created on 07.10.2021.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0, *)
struct Clock: View {

    // MARK: - Internal Properties

    var counter: Int
    var countTo: Int
    
    // MARK: - Private Properties

    @ObservedObject var schemeProvider: SchemeProvider<ClockScheme>

    // MARK: - Initializer

    init(
        counter: Int,
        countTo: Int,
        schemeProvider: SchemeProvider<ClockScheme> = AppThemeSchemeProvider<ClockScheme>()
    ) {
        self.counter = counter
        self.countTo = countTo
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    var body: some View {
        let scheme = schemeProvider.scheme
        VStack {
            Text(counterToMinutes())
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
        }
    }

    // MARK: - Internal Methods
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        
        return "\(seconds)"
    }
    
}

@available(iOS 14.0, *)
struct ProgressBar: View {
    
    var counter: Int
    var countTo: Int
    
    // MARK: - Private Properties

    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ProgressBarScheme>()

    // MARK: - Initiazer

    init(counter: Int, countTo: Int) {
        self.counter = counter
        self.countTo = countTo
    }

    // MARK: - Body
    
    var body: some View {
        let scheme = schemeProvider.scheme
        Circle()
            .trim(from: progress(), to: 1)
            .stroke(
                style: StrokeStyle(
                    lineWidth: LayoutGrid.halfModule / 2,
                    lineCap: .round,
                    lineJoin:.round
                )
            )
            .foregroundColor(scheme.tintColor.swiftUIColor)
            .animation(counter == 0 ? nil : .linear(duration: 1))
    }

    // MARK: - Internal Methods

    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo - 1))
    }
}

@available(iOS 14.0, *)
struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressBar(counter: 0, countTo: 10)
        }
    }
}


@available(iOS 14.0, *)
public struct CountdownView: View {
    
    // MARK: - Internal Properties
    
    @State var counter: Int = 0
    var countTo: Int
    
    // MARK: - Private Properties
    
    @State private var countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MARK: - Initializer
    
    public init(countTo: Int) {
        self.countTo = countTo
        startTimer()
    }
    
    public var body: some View {
        VStack{
            ZStack{
                ProgressBar(counter: counter, countTo: countTo)
                Clock(counter: counter, countTo: countTo)
            }
        }.onReceive(countdownTimer) { time in
            if (self.counter < self.countTo) {
                self.counter += 1
            } else {
                cancelTimer()
            }
        }
        .onDisappear {
            cancelTimer()
        }
    }
    
    // MARK: - Private Methods
    
    private func startTimer() {
        counter = 0
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    private func cancelTimer() {
        counter = 0
        countdownTimer.upstream.connect().cancel()
    }
}

@available(iOS 14.0, *)
struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(countTo: 5)
    }
}
