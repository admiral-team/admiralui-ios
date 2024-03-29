//
//  CountdownView.swift
//  AdmiralSwiftUI
//
//  Created on 07.10.2021.
//

import AdmiralTheme
import SwiftUI
/**
 CountdownView - the view that contains progress bar and clock view to attach the limited time with timer.
 You can create a ChatInput by specifying the following parameters in the initializer:
 - countTo: Int - The end of the timer.

 ## Example to create CountdownView:
 # Code
 ```
 CountdownView(countTo: 5)
 ```
*/
@available(iOS 14.0, *)
public struct CountdownView: View {

    // MARK: - Internal Properties

    @State var counter: Int = 0
    var countTo: Int

    // MARK: - Private Properties

    @ObservedObject var schemeProvider: SchemeProvider<CoundDownViewScheme>

    @State private var countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // MARK: - Initializer

    public init(
        countTo: Int,
        schemeProvider: SchemeProvider<CoundDownViewScheme> = AppThemeSchemeProvider<CoundDownViewScheme>()
    ) {
        self.countTo = countTo
        self.schemeProvider = schemeProvider
        startTimer()
    }

    public var body: some View {
        VStack{
            ZStack{
                ProgressBar(
                    counter: counter,
                    countTo: countTo,
                    schemeProvider: .constant(scheme: schemeProvider.scheme.progressBarScheme)
                )
                Clock(
                    counter: counter,
                    countTo: countTo,
                    schemeProvider: .constant(scheme: schemeProvider.scheme.clockViewScheme)
                )
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
