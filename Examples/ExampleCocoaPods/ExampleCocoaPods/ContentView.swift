//
//  ContentView.swift
//  ExampleCocoaPods
//
//  Created by ANpolyakov on 29.06.2021.
//

import SwiftUI
import AdmiralUIKit
import AdmiralSwiftUI

struct ContentView: View {
        
    var body: some View {
        VStack() {
            Spacer()
            PrimaryButton(text: "SwitUI", action: {})
            WrapedPrimaryButton(text: .constant("UIKit"))
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            Spacer()
        }.padding(.horizontal)
    }
}

struct WrapedPrimaryButton: UIViewRepresentable {
    @Binding var text: String?

    func makeUIView(context: Context) -> UIButton {
        return AdmiralUIKit.PrimaryButton();
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        uiView.setTitle(text, for: .normal);
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
